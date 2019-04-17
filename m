Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEDFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DEE20674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbfDQPgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:36:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731472AbfDQPga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:36:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3HFXtds034785
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:36:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rx50pnfjk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:36:29 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 17 Apr 2019 16:36:28 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Apr 2019 16:36:24 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3HFaNT811468962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 15:36:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37D7EB2064;
        Wed, 17 Apr 2019 15:36:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B200B206A;
        Wed, 17 Apr 2019 15:36:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 17 Apr 2019 15:36:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8703B16C61BE; Wed, 17 Apr 2019 08:36:24 -0700 (PDT)
Date:   Wed, 17 Apr 2019 08:36:24 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        mathieu.desnoyers@efficios.com,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Reply-To: paulmck@linux.ibm.com
References: <20190410195708.162185-1-joel@joelfernandes.org>
 <20190410195708.162185-3-joel@joelfernandes.org>
 <20190410161112.540017d9@gandalf.local.home>
 <20190410202902.GA167446@google.com>
 <20190410204401.62f928ca@gandalf.local.home>
 <20190417151618.GD17099@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417151618.GD17099@linux-8ccs>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041715-0072-0000-0000-0000041B4A6B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010944; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190421; UDB=6.00623801; IPR=6.00971220;
 MB=3.00026487; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 15:36:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041715-0073-0000-0000-00004BDCB343
Message-Id: <20190417153624.GI14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 05:16:18PM +0200, Jessica Yu wrote:
> +++ Steven Rostedt [10/04/19 20:44 -0400]:
> >On Wed, 10 Apr 2019 16:29:02 -0400
> >Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> >>The srcu structure pointer array is modified at module load time because the
> >>array is fixed up by the module loader at load-time with the final locations
> >>of the tracepoints right?  Basically relocation fixups. At compile time, I
> >>believe it is not know what the values in the ptr array are. I believe same
> >>is true for the tracepoint ptrs array.
> >>
> >>Also it needs to be in a separate __tracepoint_ptrs so that this code works:
> >>
> >>
> >>#ifdef CONFIG_TRACEPOINTS
> >>	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
> >>					     sizeof(*mod->tracepoints_ptrs),
> >>					     &mod->num_tracepoints);
> >>#endif
> >>
> >>Did I  miss some point? Thanks,
> >
> >But there's a lot of others too. Hmm, does this mean that the RO data
> >sections that are in modules are not set to RO?
> >
> >There's a bunch of separate sections that are RO. Just look in
> >include/asm-generic/vmlinux.lds.h under the RO_DATA_SECTION() macro.
> >
> >A lot of the sections saved in module.c:find_module_sections() are in
> >that RO_DATA when compiled as a builtin. Are they not RO when loaded via
> >a module?
> 
> Unlike the kernel, the module loader does not rely on a linker script
> to determine which sections get what protections. On module load, all
> sections in a module are looped through and those sections without the
> SHF_WRITE flag will be set to RO. For example, when there is a section
> filled with structs declared as const or if the section was explicitly
> given only the SHF_ALLOC attribute, those will be read-only. As long
> as the sections were given the correct section attributes for
> read-only, it'll have read-only protection. I see this is already the
> case for __param and  __ksymtab*/__kcrctab* sections, but I agree that
> a full audit would be useful to be consistent with builtin RO
> protections.

Thank you very much for the explanation!

							Thanx, Paul

