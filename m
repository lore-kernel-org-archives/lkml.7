Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3120AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00061206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfDOKMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:12:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726034AbfDOKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:12:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FA9LGK139884
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 06:12:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rvq1r37ar-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 06:12:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <anju@linux.vnet.ibm.com>;
        Mon, 15 Apr 2019 11:12:14 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 11:12:11 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FACA2M56426684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 10:12:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5075E5205F;
        Mon, 15 Apr 2019 10:12:10 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.161.180])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 271175204F;
        Mon, 15 Apr 2019 10:12:09 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: [PATCH v4 0/5] powerpc/perf: IMC trace-mode support
Date:   Mon, 15 Apr 2019 15:41:59 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19041510-4275-0000-0000-00000327F119
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041510-4276-0000-0000-000038371B5E
Message-Id: <20190415101204.15125-1-anju@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=855 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMC (In-Memory collection counters) is a hardware monitoring facility      
that collects large number of hardware performance events.                 
POWER9 support two modes for IMC which are the Accumulation mode and       
Trace mode. In Accumulation mode, event counts are accumulated in system   
Memory. Hypervisor then reads the posted counts periodically or when       
requested. In IMC Trace mode, the 64 bit trace scom value is initialized
with the event information. The CPMC*SEL and CPMC_LOAD in the trace scom, specifies
the event to be monitored and the sampling duration. On each overflow in the
CPMC*SEL, hardware snapshots the program counter along with event counts
and writes into memory pointed by LDBAR. LDBAR has bits to indicate whether
hardware is configured for accumulation or trace mode.
Currently the event monitored for trace-mode is fixed as cycle.     

Trace-IMC Implementation:                                                  
--------------------------                                                 
To enable trace-imc, we need to                                            
								    
* Add trace node in the DTS file for power9, so that the new trace node can
be discovered by the kernel.                                               
								    
Information included in the DTS file are as follows, (a snippet from      
the ima-catalog)                                                           
								    
TRACE_IMC: trace-events {                                                  
     #address-cells = <0x1>;                                        
     #size-cells = <0x1>;                                           
     event at 10200000 {                                               
	 event-name = "cycles" ;                                    
	 reg = <0x10200000 0x8>;                                    
	 desc = "Reference cycles" ;                                
     };                                                             
 };                                                                 
 trace@0 {                                                          
	 compatible = "ibm,imc-counters";                           
	 events-prefix = "trace_";                                  
	 reg = <0x0 0x8>;                                           
	 events = < &TRACE_IMC >;                                   
	 type = <0x2>;                                              
	 size = <0x40000>;                                          
 };                                                                 
								    
OP-BUILD changes needed to include the "trace node" is already pulled in   
to the ima-catalog repo.                                                   
								    
ps://github.com/open-power/op-build/commit/d3e75dc26d1283d7d5eb444bff1ec9e40d5dfc07
								    
* Enchance the opal_imc_counters_* calls to support this new trace mode    
in imc. Add support to initialize the trace-mode scom.                     
								    
TRACE_IMC_SCOM bit representation:                                         
								    
0:1     : SAMPSEL                                                          
2:33    : CPMC_LOAD                                                        
34:40   : CPMC1SEL                                                         
41:47   : CPMC2SEL                                                         
48:50   : BUFFERSIZE                                                       
51:63   : RESERVED                                                         
								    
CPMC_LOAD contains the sampling duration. SAMPSEL and CPMC*SEL determines  
the event to count. BUFFRSIZE indicates the memory range. On each overflow,
hardware snapshots program counter along with event counts and update the 
memory and reloads the CMPC_LOAD value for the next sampling duration.     
IMC hardware does not support exceptions, so it quietly wraps around if    
memory buffer reaches the end.                                             

OPAL support for IMC trace mode is already upstream.

* Set LDBAR spr to enable imc-trace mode.                                  
                                                                             
  LDBAR Layout:                                                              
                                                                             
  0     : Enable/Disable                                                     
  1     : 0 -> Accumulation Mode                                             
          1 -> Trace Mode                                                    
  2:3   : Reserved                                                           
  4-6   : PB scope                                                           
  7     : Reserved                                                           
  8:50  : Counter Address                                                    
  51:63 : Reserved     

----------------------

PMI interrupt handling is avoided, since IMC trace mode snapshots the
program counter and update to the memory. And this also provide a way for
the operating system to do instruction sampling in real time without
PMI(Performance Monitoring Interrupts) processing overhead.          								    					    
Performance data using 'perf top' with and without trace-imc event:        
								    
PMI interrupts count when `perf top` command is executed without trace-imc event.
								    
# cat /proc/interrupts  (a snippet from the output)                        
9944      1072        804        804       1644        804       1306      
804        804        804        804        804        804        804      
804        804       1961       1602        804        804       1258      
[-----------------------------------------------------------------]        
803        803        803        803        803        803        803      
803        803        803        803        804        804        804     
804        804        804        804        804        804        803     
803        803        803        803        803       1306        803     
803   Performance monitoring interrupts                                   
								    
								    
`perf top` with trace-imc (executed right after 'perf top' without trace-imc event):
								    
# perf top -e trace_imc/trace_cycles/                                      
12.50%  [kernel]          [k] arch_cpu_idle                            
11.81%  [kernel]          [k] __next_timer_interrupt                   
11.22%  [kernel]          [k] rcu_idle_enter                           
10.25%  [kernel]          [k] find_next_bit                            
 7.91%  [kernel]          [k] do_idle                                  
 7.69%  [kernel]          [k] rcu_dynticks_eqs_exit                    
 5.20%  [kernel]          [k] tick_nohz_idle_stop_tick                 
     [-----------------------]                                      
								    
# cat /proc/interrupts (a snippet from the output)                         
								    
9944      1072        804        804       1644        804       1306      
804        804        804        804        804        804        804      
804        804       1961       1602        804        804       1258      
[-----------------------------------------------------------------]        
803        803        803        803        803        803        803      
803        803        803        804        804        804        804
804        804        804        804        804        804        803     
803        803        803        803        803       1306        803     
803   Performance monitoring interrupts                                   
								    
The PMI interrupts count remains the same.


Changelog:
----------
From v3 -> v4:

* trace_imc_refc is introduced. So that even if, core-imc
is disabled, trace-imc can be used.

* trace_imc_pmu_sched_task is removed and opal start/stop
is invoked in trace_imc_event_add/del function.

 
Suggestions/comments are welcome.

Anju T Sudhakar (4):
  powerpc/include: Add data structures and macros for IMC trace mode
  powerpc/perf: Rearrange setting of ldbar for thread-imc
  powerpc/perf: Trace imc events detection and cpuhotplug
  powerpc/perf: Trace imc PMU functions

Madhavan Srinivasan (1):
  powerpc/perf: Add privileged access check for thread_imc

 arch/powerpc/include/asm/imc-pmu.h        |  39 +++
 arch/powerpc/include/asm/opal-api.h       |   1 +
 arch/powerpc/perf/imc-pmu.c               | 318 +++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-imc.c |   3 +
 include/linux/cpuhotplug.h                |   1 +
 5 files changed, 351 insertions(+), 11 deletions(-)

-- 
2.17.2

