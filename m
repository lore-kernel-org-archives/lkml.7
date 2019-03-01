Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC73C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996F92084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551472501;
	bh=zPMdhnEm516p7O/8G24cqVpCK+jqvTzKWqvE+ZJZXcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=InnjmV90XkXTPIUH/nQEz1Bnd+Fa2NSYYkGqAE5bQnS8JI+uii0KUfoj3evTddgxx
	 kofaGr9DeHjFqqT/QSkpaxewCv0misr1oSrGCF9hPfTLhySJk4kcrvfKeYPn9usNYf
	 HzNXtEn8Gy/w9nMcm+P2ARUFcS01oIafywXoTIIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfCAUfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:35:00 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34798 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCAUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:34:59 -0500
Received: by mail-yw1-f68.google.com with SMTP id u205so15130667ywe.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 12:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g+Xalb+8bLs1bnYHMDuUYeNKMDZy9pBh98B7bBcq63s=;
        b=JCRj+uKEWI4QN8VV0Nai8ttuP54jaYMUG+TUc3BEagWNZn7LNWRvuDXhuIfAQ5+QQk
         VmZfkW7o+bAYi8A+QUi1tdyXnlduU48VIVAWepjZJ6vMT/gKJQiKzDMqDg5U2eenQXTU
         AuH2o4Asj8TGiqn3EyWo/ne19p0uxWjeTXwAPMcYWq+WKGoCm6JWaMkYpj7SSJtDhdqd
         KxdR2tbw7/zmiN1BAJ1ohM2E3g3cTL67iSwGVluusOc9x5wyhEvoQsxwfsJJJqjA9q8w
         ETJji0P2JNofeHkcY6sGngExtv2oT+z77nFGF3YcMTOpIeU7urkCkMTlWdzH4Vk/Ch3S
         bDSQ==
X-Gm-Message-State: APjAAAW844kdCgr//qcgiUPZ6VmcmFJn7sn/QPcxHcuA+yB83bEtxkt6
        dEuOBTUDcgpBkNeDeQP0oBY=
X-Google-Smtp-Source: APXvYqwngVehOoYVt9ZpKk0UnW+SKUByG0Jb6/UvVdGiVOMlkDScYIMizj2bNM+2LHy23G2GjtTwFw==
X-Received: by 2002:a25:2e50:: with SMTP id b16mr6022764ybn.177.1551472498636;
        Fri, 01 Mar 2019 12:34:58 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::2:23c7])
        by smtp.gmail.com with ESMTPSA id 130sm7759416ywp.54.2019.03.01.12.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 12:34:57 -0800 (PST)
Date:   Fri, 1 Mar 2019 15:34:55 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Barret Rhoden <brho@google.com>
Cc:     Eial Czerwacki <eial@scalemp.com>, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, linux-kernel@vger.kernel.org,
        Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
Message-ID: <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
 <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barret,

On Fri, Mar 01, 2019 at 01:30:15PM -0500, Barret Rhoden wrote:
> Hi -
> 
> On 01/21/2019 06:47 AM, Eial Czerwacki wrote:
> >
> 
> Your main issue was that you only sent this patch to LKML, but not the
> maintainers of the file.  If you don't, your patch might get lost.  To get
> the appropriate people and lists, run:
> 
> 	scripts/get_maintainer.pl YOUR_PATCH.patch.
> 
> For this patch, you'll get this:
> 
> Dennis Zhou <dennis@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> Tejun Heo <tj@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> Christoph Lameter <cl@linux.com> (maintainer:PER-CPU MEMORY ALLOCATOR)
> linux-kernel@vger.kernel.org (open list)
> 
> I added the three maintainers to this email.
> 
> I have a few minor comments below.
> 
> > [PATCH] percpu/module resevation: change resevation size iff X86_VSMP is
> set
> 
> You misspelled 'reservation'.  Also, I'd just say: "percpu: increase module
> reservation size if X86_VSMP is set".  ('change' -> 'increase'), only says
> 'reservation' once.)
> 
> > as reported in bug #201339 (https://bugzilla.kernel.org/show_bug.cgi?id=201339)
> 
> I think you can add a tag for this right above your Signed-off-by tags.
> e.g.:
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201339
> 
> > by enabling X86_VSMP, INTERNODE_CACHE_BYTES's definition differs from the default one
> > causing the struct size to exceed the size ok 8KB.
>                                             ^of
> 
> Which struct are you talking about?  I have one in mind, but others might
> not know from reading the commit message.
> 
> I ran into this on https://bugzilla.kernel.org/show_bug.cgi?id=202511. In
> that case, it was because modules (drm and amdkfd) were using DEFINE_SRCU,
> which does a DEFINE_PER_CPU on struct srcu_data, and that used
> ____cacheline_internodealigned_in_smp.
> 
> > 
> > in order to avoid such issue, increse PERCPU_MODULE_RESERVE to 64KB if CONFIG_X86_VSMP is set.
>                                ^increase
> 
> > 
> > the value was caculated on linux 4.20.3, make allmodconfig all and the following oneliner:
>                ^calculated
> 
> > for f in `find -name *.ko`; do echo $f; readelf -S $f  |grep perc; done |grep data..percpu -B 1 |grep ko |while read r; do echo -n "$r: "; objdump --syms --section=.data..percpu $r|grep data |sort -n  |awk '{c++; d=strtonum("0x" $1) + strtonum("0x" $5); if (m < d) m = d;} END {printf("%d vars-> last addr 0x%x ( %d )\n", c, m, m)}' ; done |column -t |sort -k 8 -n | awk '{print $8}'| paste -sd+ | bc
> 
> Not sure how useful the one-liner is, versus a description of what you're
> doing.  i.e. "the size of all module percpu data sections, or something."
> 
> Also, how close was that calculated value to 64K?  If more modules start
> using DEFINE_SRCU, each of which uses 8K, then that 64K might run out.
> 
> Thanks,
> Barret
> 
> > Signed-off-by: Eial Czerwacki <eial@scalemp.com>
> > Signed-off-by: Shai Fultheim <shai@scalemp.com>
> > Signed-off-by: Oren Twaig <oren@scalemp.com>
> > ---
> >   include/linux/percpu.h | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> > index 70b7123..6b79693 100644
> > --- a/include/linux/percpu.h
> > +++ b/include/linux/percpu.h
> > @@ -14,7 +14,11 @@
> >   /* enough to cover all DEFINE_PER_CPUs in modules */
> >   #ifdef CONFIG_MODULES
> > +#ifdef X86_VSMP
> > +#define PERCPU_MODULE_RESERVE		(1 << 16)
> > +#else
> >   #define PERCPU_MODULE_RESERVE		(8 << 10)
> > +#endif
> >   #else
> >   #define PERCPU_MODULE_RESERVE		0
> >   #endif
> > 
> 

Thanks for sending this to me.

I must say, I really do not want to expand the reserved region. In most
cases, it can easily end up unused and thus wasted memory as it is hard
allocated on boot. This is done because code gen assumes static
variables are close to the program counter. This would not be true with
dynamic allocations which being at the end of the vmalloc area
(Summarized from Tejun's account in [1]).

Another note on the reserved region. It starts at the end of the static
region which means it generally isn't page aligned. So while an 8kb
allocation would fit, a 4kb alignment more than likely would fail.
Something as large as 8kb should probably be dynamically allocated as
well.

I read through the bugzilla report and it seems that the culprits are:
  drivers/gpu/drm/amd/amdkfd/kfd_process.c:DEFINE_SRCU(kfd_processes_srcu);
  drivers/gpu/drm/drm_drv.c:DEFINE_STATIC_SRCU(drm_unplug_srcu);

Is there a reason we cannot dynamically initialize these structs? I've
cced Paul McKenney because we saw an issue with ipmi in December [1].

[1] https://lore.kernel.org/linux-mm/CAJM9R-JWO1P_qJzw2JboMH2dgPX7K1tF49nO5ojvf=iwGddXRQ@mail.gmail.com/

Thanks,
Dennis
