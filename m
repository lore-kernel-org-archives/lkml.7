Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C842AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B832073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575987579;
	bh=ov5MQDFCsosZzZFCs7On3D9TRwkmnckEYiB2mMwLlIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RvzAkjIa8F5vHIN2tpwFgPnnwlJws/v06z3m3RTXfi4VlR542XbEW1cTaVihOS1Ss
	 s9jttaaDRfHGoPWrk5cvB+cTY8w0OdFkQdbFWatt5Llh7Ce0aWkv2fOtbGmiE9mAYd
	 LpdKxnWgctC3BZHnVUS23XEc05c8wvHdcp4C5wzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLJOTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:19:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36053 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:19:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so3402744wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 06:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vvShKcPkNNNZPmf7EcjJYAypgpc9NXZSs5nDPjN1qQA=;
        b=JtKHQkJI38o9lYxquTSteA0vr7XcA52EXq3NOeF1URT8+Gvh3X6+T0OsRo+f6qI29+
         bIEs9QfdyTb5tD0FR/8D8N02//Ol93lnWdHjg+ES/s/3Kh0sKYQmEgFUQ1Up7pzbJye8
         KjOLWY+yP2kmR7JU3lakxZII41RKDFxZLGVFrrw+9J2BJWQHxU8N4yNW7A0qUo43PDaH
         Ey8mNMeFKk080jTjwbOgmMNuTk5C9iTrKTYE8V1rAU/aBgxOqzYGE703PpgMfLIH8Xbs
         lTPjX1p23Pxmf7ZINsES93+weonmuawjFJ5/PdVzcG5tDKtQ6PT0ubNqu8dWLj5I9wvU
         Vg3A==
X-Gm-Message-State: APjAAAVFMCjbVM0ZJgg2ktj9g1GW8Wp99e2wT+rMaPw+M9QCzj32kwFR
        0mW6XSrUrfT8K1gkHsSAohU=
X-Google-Smtp-Source: APXvYqxf446sXqtpzu0nV99LjNCiKJty0osulSpIpx9pagCwolcdBKEWtSanOJVj9s9RvcUKxyVdmA==
X-Received: by 2002:a1c:f60f:: with SMTP id w15mr5357176wmc.132.1575987576101;
        Tue, 10 Dec 2019 06:19:36 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id l15sm3380558wrv.39.2019.12.10.06.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:19:35 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:19:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191210141934.GL10404@dhcp22.suse.cz>
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
 <20191210072453.GI2984@MiWiFi-R3L-srv>
 <20191210102834.GE10404@dhcp22.suse.cz>
 <20191210104303.GN2984@MiWiFi-R3L-srv>
 <20191210113341.GG10404@dhcp22.suse.cz>
 <20191210125557.GA28917@MiWiFi-R3L-srv>
 <20191210133202.GJ10404@dhcp22.suse.cz>
 <20191210140534.GB28917@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210140534.GB28917@MiWiFi-R3L-srv>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-12-19 22:05:34, Baoquan He wrote:
> On 12/10/19 at 02:32pm, Michal Hocko wrote:
> > On Tue 10-12-19 20:55:57, Baoquan He wrote:
> > [...]
> > > Btw, as you said at above, I am confused by the '[KNL,BOOT]', what does
> > > the 'BOOT' mean in the documentation of 'mem='? I checked all parameters
> > > with 'BOOT', still don't get it clearly.
> > 
> > This is a good question indeed. I have checked closer and this is what
> > documentation says
> > Documentation/admin-guide/kernel-parameters.rst
> > "
> >         BOOT    Is a boot loader parameter.
> > 
> > Parameters denoted with BOOT are actually interpreted by the boot
> > loader, and have no meaning to the kernel directly.
> > "
> > 
> > and that really doesn't fit, right? So I went to check the full history
> > git tree just to get to 2.4.0-test5 and no explanation whatsoever.
> > Fun, isn't it? ;)
> 
> Yeah, very interesting. Finally I got their original purpose from
> Documentation/x86/boot.rst.
> 
> 
> Special Command Line Options
> ============================
> 
> If the command line provided by the boot loader is entered by the
> user, the user may expect the following command line options to work.
> They should normally not be deleted from the kernel command line even
> though not all of them are actually meaningful to the kernel.  Boot
> loader authors who need additional command line options for the boot
> loader itself should get them registered in
> Documentation/admin-guide/kernel-parameters.rst to make sure they will not
> conflict with actual kernel options now or in the future.
> 
> ...
> 
> So here, [KNL,BOOT], KNL means it's used for kernel, BOOT means it's
> needed by boot loader.

OK, that clarifies this a bit. Thanks for referencing to it!
That should explain how the behavior is not boot time restricted at all
and the current implementation is actually correct. So a change to it
should clearly state the new usecase as we have already discussed. In
case there are bootloaders which really rely on the original strict
meaning then we should be able to compare cost/benfits of those two
usecases.
-- 
Michal Hocko
SUSE Labs
