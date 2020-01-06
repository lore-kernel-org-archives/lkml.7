Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A69C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B4A20731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNwjPWhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgAFKur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:50:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43704 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725821AbgAFKuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578307844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qU0SboNEBDWBERvxqixCdqMTzHYQoyobKNvA/+6rjvk=;
        b=ZNwjPWhvWINj1ikJUChrwoa6Jn2wfDhGJF6Wst4FKRqwx+67aH7tD98X8Aee5tOFMxIQlB
        Ey1B61ySklwzC/xzcwGhEq/5X2Rrx7QQJe+toVN7P47Q+mFQP7/YFG6NHCA++k0/y4Qqdk
        NaZjQZxUtz5J7PKYdMpHJgvZZ5HdwDI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-tOhGo3UPMWizJljs6avP8A-1; Mon, 06 Jan 2020 05:50:41 -0500
X-MC-Unique: tOhGo3UPMWizJljs6avP8A-1
Received: by mail-qk1-f199.google.com with SMTP id a6so26402727qkl.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 02:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qU0SboNEBDWBERvxqixCdqMTzHYQoyobKNvA/+6rjvk=;
        b=N8MoPlHPZEx/9lzNO3tow4ZoTI1gkrqC/OuNeWsISwu3mKb07JwxV3oOiBEyv9yobn
         E9T+4FbmAZo6rFBJVzqa4AyRzSuSnaiIHqHmKlnlGuslqFX+tBOnAGEnl3dB1oq2iZjb
         6HMiiuW7Z3zAzIX1lamE7FySlXLhKZGjcq3IsGc3lscTyluhkMwSHpCUIynmniZjDiNM
         U78+tVzMlotgS3hIRQSxjOdhKlRGTSscBGSOfQz9sRzwV2/QhaYi9zDuGOkC9G+6LIyo
         rfPG3jWnUI8Ai0HlmQiHu4STg4PSdtPSKNoUVht+F0zKHcDK0TZciwY+E80TgoyBOokc
         kOxw==
X-Gm-Message-State: APjAAAU/8uWm89st9f5aaW+IGb1tBIKSUMqcmibKpm845imKldvhzSby
        My6VsGI+BS7xxlECEOu1yWOJvsDqaMXipsBdvn5FvZrXkK//lrifG/UceNYrktFhAKTYj98YtyL
        J2ddH3vK6g7AqOxJ1E6U+/1Ca
X-Received: by 2002:a37:65c7:: with SMTP id z190mr77575626qkb.261.1578307841388;
        Mon, 06 Jan 2020 02:50:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBMNWp3jpUCJz4gy7m1LfPpAYW3QX/zbzMI48HgZMdTtTpUk7nhqdKrFjR8fz3UtWCh133Iw==
X-Received: by 2002:a37:65c7:: with SMTP id z190mr77575606qkb.261.1578307841125;
        Mon, 06 Jan 2020 02:50:41 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id e2sm20313422qkb.112.2020.01.06.02.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 02:50:40 -0800 (PST)
Date:   Mon, 6 Jan 2020 05:50:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Message-ID: <20200106054041-mutt-send-email-mst@kernel.org>
References: <c022e1d6-0d57-ae07-5e6b-8e40d3b01f4b@de.ibm.com>
 <20191218100926-mutt-send-email-mst@kernel.org>
 <2ffdbd95-e375-a627-55a1-6990b0a0e37a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffdbd95-e375-a627-55a1-6990b0a0e37a@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 04:59:02PM +0100, Christian Borntraeger wrote:
> On 18.12.19 16:10, Michael S. Tsirkin wrote:
> > On Wed, Dec 18, 2019 at 03:43:43PM +0100, Christian Borntraeger wrote:
> >> Michael,
> >>
> >> with 
> >> commit db7286b100b503ef80612884453bed53d74c9a16 (refs/bisect/skip-db7286b100b503ef80612884453bed53d74c9a16)
> >>     vhost: use batched version by default
> >> plus
> >> commit 6bd262d5eafcdf8cdfae491e2e748e4e434dcda6 (HEAD, refs/bisect/bad)
> >>     Revert "vhost/net: add an option to test new code"
> >> to make things compile (your next tree is not easily bisectable, can you fix that as well?).
> > 
> > I'll try.
> > 
> >>
> >> I get random crashes in my s390 KVM guests after reboot.
> >> Reverting both patches together with commit decd9b8 "vhost: use vhost_desc instead of vhost_log" to
> >> make it compile again) on top of linux-next-1218 makes the problem go away.
> >>
> >> Looks like the batched version is not yet ready for prime time. Can you drop these patches until
> >> we have fixed the issues?
> >>
> >> Christian
> >>
> > 
> > Will do, thanks for letting me know.
> 
> I have confirmed with the initial reporter (internal test team) that <driver name='qemu'/> 
> with a known to be broken linux next kernel also fixes the problem, so it is really the
> vhost changes.

OK I'm back and trying to make it more bisectable.

I pushed a new tag "batch-v2".
It's same code but with this bisect should get more information.


I suspect one of the following:

commit 1414d7ee3d10d2ec2bc4ee652d1d90ec91da1c79
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Mon Oct 7 06:11:18 2019 -0400

    vhost: batching fetches
    
    With this patch applied, new and old code perform identically.
    
    Lots of extra optimizations are now possible, e.g.
    we can fetch multiple heads with copy_from/to_user now.
    We can get rid of maintaining the log array.  Etc etc.
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

commit 50297a8480b439efc5f3f23088cb2d90b799acef
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Wed Dec 11 12:19:26 2019 -0500

    vhost: use batched version by default
    
    As testing shows no performance change, switch to that now.
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


and would like to know which.

Thanks!


