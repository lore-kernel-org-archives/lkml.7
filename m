Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EECBC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B222343A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YqAp1gZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfH3VNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:13:55 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:37363 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfH3VNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:13:54 -0400
Received: by mail-qk1-f178.google.com with SMTP id s14so7458122qkm.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=9IiJZpTOSKCR6WBakH7U6sQn4CVu6WS5L5+lBv5zZD8=;
        b=YqAp1gZnZGhxy+02UnsSNupu7fjtaE0/i2HaaFGvIhcULR4hjVd4JoVJn34+hKBhLe
         8N/em8npCSQtXMgnsEOlprv+hv4/UEGIC7NrdGwKEbii4Mpvx5WHvY5rN3kYlV1OsWLq
         AxjpK4vUL71fRI5LiwGy7I0v/6+BATFU6kQOxoNMElSnnnm8hdHrVf00BPDlFiFtucJx
         xpuPxoJEO6MAhpPDDk1ohzEr1xJRhp9uJUBYFEC0ZwwtkapNKk8/nwjTVusDTNOJtlSe
         6gqeZyQPy/dAyrKYEx3BbqBAiLy/c4Ghvnx7td96UddgzuxPPStDNSbalxV0FAnBm9/J
         SQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=9IiJZpTOSKCR6WBakH7U6sQn4CVu6WS5L5+lBv5zZD8=;
        b=QuobacbqTxU+y49ytbAZllATEPTmrJ+UehxcksKUBkH1YIsTHi7JvZGVceZjlXz7gY
         Er0bUXEGVef0sNvPFDCbl/Bcgd3W2Os0I2uHBcctRGAunwJD+zSaDwIPzoTdZYjygsZt
         sd3JKUsQlGufWcxTriXCxLSBb4PeawTs9rqIcfg6gvNDUh7PtNoCDdpK4x+GC2jJxLzH
         Obd0ana4JrgchjapJBjDri9GO8gnLhG27ZwnbilvkdLiV9n/ghPBt7J1jF09+QItFcOi
         KwMm/8Z4Yadez+6okIdasoz68zDprTc/vrAJx2Gte5T1T/aMJxoj9/66pXYE3w9l7RHk
         RAKg==
X-Gm-Message-State: APjAAAUSWKSRj1hX/bU/BWoSh9WUMISw0A6Y2Thhrq5HxorGTvU9mjqs
        xmAcYGr94CV8ykOuo3Dhbz20uQ==
X-Google-Smtp-Source: APXvYqwf+deiXMLQ1zMscUAYYr5DMgHb0Cq82Gs2lVSvOmUvm3SfCqYCe4A0+PRYJnHkzWzvTqo+cg==
X-Received: by 2002:a37:7b06:: with SMTP id w6mr17404332qkc.436.1567199632974;
        Fri, 30 Aug 2019 14:13:52 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c14sm2226977qta.80.2019.08.30.14.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 14:13:52 -0700 (PDT)
Message-ID: <1567199630.5576.39.camel@lca.pw>
Subject: lockdep warning while booting POWER9 PowerNV
From:   Qian Cai <cai@lca.pw>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 17:13:50 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config

Once in a while, booting an IBM POWER9 PowerNV system (8335-GTH) would generate
a warning in lockdep_register_key() at,

if (WARN_ON_ONCE(static_obj(key)))

because

key = 0xc0000000019ad118
&_stext = 0xc000000000000000
&_end = 0xc0000000049d0000

i.e., it will cause static_obj() returns 1.


[   23.738200][   T13] ahci 0004:03:00.0: enabling device (0541 -> 0543)
[   23.748692][    T5] tg3.c:v3.137 (May 11, 2014)
[   23.748731][    T5] tg3 0005:01:00.0: enabling device (0140 -> 0142)
[   23.751478][   T13] ahci 0004:03:00.0: AHCI 0001.0000 32 slots 4 ports 6 Gbps
0xf impl SATA mode
[   23.751517][   T13] ahci 0004:03:00.0: flags: 64bit ncq sntf led only pmp fbs
pio slum part sxs 
[   23.791077][   T13] scsi host0: ahci
[   23.802752][   T13] ------------[ cut here ]------------
[   23.802786][   T13] WARNING: CPU: 0 PID: 13 at kernel/locking/lockdep.c:1120
lockdep_register_key+0x68/0x200
[   23.802814][   T13] Modules linked in: mdio tg3(+) ahci(+) libahci libphy
firmware_class libata dm_mirror dm_region_hash dm_log dm_mod
[   23.802884][   T13] CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 5.3.0-rc6-
next-20190830 #4
[   23.802930][   T13] Workqueue: events work_for_cpu_fn
[   23.802962][   T13] NIP:  c00000000019eed8 LR: c000000000129400 CTR:
c0000000008a46dc
[   23.802988][   T13] REGS: c00000002db2f130 TRAP: 0700   Not tainted  (5.3.0-
rc6-next-20190830)
[   23.803032][   T13] MSR:  900000000282b033
<SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 48800a89  XER: 20040000
[   23.803096][   T13] CFAR: c00000000019eeac IRQMASK: 0 
[   23.803096][   T13] GPR00: c000000000129400 c00000002db2f3c0 c000000002bb9400
c0000000049d0000 
[   23.803096][   T13] GPR04: 0000000000000000 c000000002d84718 0000000000000000
ffff0a01ffffff10 
[   23.803096][   T13] GPR08: c000000000b8a16b c000000000a515cc c000000000b8a16a
0000000000000044 
[   23.803096][   T13] GPR12: 0000000088800a89 c0000000049d0000 c00800000eea3290
0000000000000001 
[   23.803096][   T13] GPR16: c000001bca584500 c000000007244954 c000001bca584508
0000000000000020 
[   23.803096][   T13] GPR20: c000000001aea180 0000000000000001 c00800000eee7560
c000001bca584500 
[   23.803096][   T13] GPR24: c000001bca584448 000000000002000a c000000001aea148
c000000000b8a161 
[   23.803096][   T13] GPR28: c000000001aea020 c000000001aea118 c000000001aea000
c00000002db2f440 
[   23.803407][   T13] NIP [c00000000019eed8] lockdep_register_key+0x68/0x200
[   23.803432][   T13] LR [c000000000129400] wq_init_lockdep+0x40/0xc0
[   23.803461][   T13] Call Trace:
[   23.803491][   T13] [c00000002db2f3c0] [c000000000b8a16a]
trunc_msg+0x385f9/0x4c30f (unreliable)
[   23.803531][   T13] [c00000002db2f440] [c000000000129400]
wq_init_lockdep+0x40/0xc0
[   23.803577][   T13] [c00000002db2f4c0] [c000000000128d90]
alloc_workqueue+0x1e0/0x620
[   23.803623][   T13] [c00000002db2f5c0] [c0000000006ca048]
scsi_host_alloc+0x3d8/0x490
[   23.803701][   T13] [c00000002db2f660] [c00800000ee73198]
ata_scsi_add_hosts+0xd0/0x220 [libata]
[   23.803771][   T13] [c00000002db2f6f0] [c00800000ee6d440]
ata_host_register+0x178/0x400 [libata]
[   23.803840][   T13] [c00000002db2f7d0] [c00800000ee6d8f4]
ata_host_activate+0x17c/0x210 [libata]
[   23.803883][   T13] [c00000002db2f880] [c00800000edf4c3c]
ahci_host_activate+0x84/0x250 [libahci]
[   23.803944][   T13] [c00000002db2f940] [c00800000f050c7c]
ahci_init_one+0xc74/0xdc0 [ahci]
[   23.803992][   T13] [c00000002db2faa0] [c00000000062b188]
local_pci_probe+0x78/0x100
[   23.804048][   T13] [c00000002db2fb30] [c00000000012c0b0]
work_for_cpu_fn+0x40/0x70
[   23.804087][   T13] [c00000002db2fb60] [c000000000130328]
process_one_work+0x388/0x750
[   23.804135][   T13] [c00000002db2fc60] [c00000000012fe30]
process_scheduled_works+0x50/0x90
[   23.804180][   T13] [c00000002db2fca0] [c000000000130c50]
worker_thread+0x3d0/0x570
[   23.804216][   T13] [c00000002db2fda0] [c000000000139a08] kthread+0x1b8/0x1e0
[   23.804253][   T13] [c00000002db2fe20] [c00000000000b660]
ret_from_kernel_thread+0x5c/0x7c
[   23.804298][   T13] Instruction dump:
[   23.804326][   T13] fbc10070 4194002c 7fa3eb78 481864a5 60000000 70630001
41810018 7fa3eb78 
[   23.804373][   T13] 48075121 60000000 70630001 40810020 <0fe00000> ebc10070
eba10068 38210080 
[   23.804419][   T13] ---[ end trace 9ceca43eedad2a2b ]---
[   23.810924][    T5] tg3 0005:01:00.0 eth0: Tigon3 [partno(BCM95719) rev
5719001] (PCI Express) MAC address 08:94:ef:80:81:c0
[   23.810967][    T5] tg3 0005:01:00.0 eth0: attached PHY is 5719C
(10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   23.811027][    T5] tg3 0005:01:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0]
ASF[1] TSOcap[1]
[   23.811074][    T5] tg3 0005:01:00.0 eth0: dma_rwctrl[00000000] dma_mask[64-
bit]
[   23.811284][   T13] scsi host1: ahci
