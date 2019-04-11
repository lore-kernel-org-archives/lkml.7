Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD49C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4622184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfDKNoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:44:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726655AbfDKNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:44:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BDbD8w121537
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:44:35 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rt6cysdxg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:44:34 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 11 Apr 2019 14:44:34 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 14:44:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3BDiShL32243756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 13:44:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E57A6B2065;
        Thu, 11 Apr 2019 13:44:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B830BB205F;
        Thu, 11 Apr 2019 13:44:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 13:44:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BFC7916C32C2; Thu, 11 Apr 2019 06:44:28 -0700 (PDT)
Date:   Thu, 11 Apr 2019 06:44:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        keescook@chromium.org, mathieu.desnoyers@efficios.com,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Reply-To: paulmck@linux.ibm.com
References: <20190410195708.162185-1-joel@joelfernandes.org>
 <20190410195708.162185-3-joel@joelfernandes.org>
 <20190410161112.540017d9@gandalf.local.home>
 <20190410202902.GA167446@google.com>
 <20190410204401.62f928ca@gandalf.local.home>
 <20190411082106.GB167446@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411082106.GB167446@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041113-2213-0000-0000-00000375012F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010908; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187551; UDB=6.00622058; IPR=6.00968315;
 MB=3.00026393; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 13:44:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041113-2214-0000-0000-00005DFC1540
Message-Id: <20190411134428.GY14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 04:21:06AM -0400, Joel Fernandes wrote:
> On Wed, Apr 10, 2019 at 08:44:01PM -0400, Steven Rostedt wrote:
> > On Wed, 10 Apr 2019 16:29:02 -0400
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > The srcu structure pointer array is modified at module load time because the
> > > array is fixed up by the module loader at load-time with the final locations
> > > of the tracepoints right?  Basically relocation fixups. At compile time, I
> > > believe it is not know what the values in the ptr array are. I believe same
> > > is true for the tracepoint ptrs array.
> > > 
> > > Also it needs to be in a separate __tracepoint_ptrs so that this code works:
> > > 
> > > 
> > > #ifdef CONFIG_TRACEPOINTS
> > > 	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
> > > 					     sizeof(*mod->tracepoints_ptrs),
> > > 					     &mod->num_tracepoints);
> > > #endif
> > > 
> > > Did I  miss some point? Thanks,
> > 
> > But there's a lot of others too. Hmm, does this mean that the RO data
> > sections that are in modules are not set to RO?
> > 
> > There's a bunch of separate sections that are RO. Just look in
> > include/asm-generic/vmlinux.lds.h under the RO_DATA_SECTION() macro.
> > 
> > A lot of the sections saved in module.c:find_module_sections() are in
> > that RO_DATA when compiled as a builtin. Are they not RO when loaded via
> > a module?
> > 
> > If this is the case, there probably is going to be a lot more sections
> > added to your list.
> 
> Hi Steven,
> 
> You are right. It turns out that this patch for tracepoint is not needed
> since each tracepoint pointer is marked as a const which automatically makes
> the section non-writable after relocations..
> 
> #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> typedef const int tracepoint_ptr_t;
> #else
> typedef struct tracepoint * const tracepoint_ptr_t;
> #endif
> 
> So the fix for SRCU could just be the following. I verified with the change
> that the ELF section section is marked only with the ALLOCATE flag, not the
> WRITE flag which should automatically put the srcu pointer array in rodata.
> I'll test this out tomorrow.
> 
> Patch 2/3 and 3/3 would not be nececessary if this works out. 1/3 may be a
> nice clean up but is not something urgent and we could do that in the future
> if needed.
> 
> Any thoughts? Thanks a lot for the review!
> 
> (I believe it is still worth auditing other sections in built-in RODATA and
> making sure they are non-writable for modules as well).

Nice and simple change!  ;-)

If it works and Steve is OK with it, I will be happy to take the
corresponding formal patch.

							Thanx, Paul

> ---8<-----------------------
> 
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 8af1824c46a8..9cfcc8a756ae 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -123,7 +123,7 @@ struct srcu_struct {
>  #ifdef MODULE
>  # define __DEFINE_SRCU(name, is_static)					\
>  	is_static struct srcu_struct name;				\
> -	struct srcu_struct *__srcu_struct_##name			\
> +	struct srcu_struct * const __srcu_struct_##name			\
>  		__section("___srcu_struct_ptrs") = &name
>  #else
>  # define __DEFINE_SRCU(name, is_static)					\
> 

