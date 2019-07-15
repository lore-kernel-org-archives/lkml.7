Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE49DC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7423206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563211703;
	bh=9E0ZytSBTx4ARSQXikFxFqt26WTjZZg9YEuzJOE71XY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oiouq+NFdQiNacUj0n/6GfU9Af9JQvPaRw6F5tZbbXBsdIL0GXaLXK6pbwBZCpdwc
	 tcyUL9Ino0UnUq4ly/p8B2OC+Dx6P/sql33ST+Bvdb/9T5Nm0BEDZTYcH9B8yd9bBU
	 FowHlFYC7Y+++OeJePq1xvLK88JpTYNVNtckfDX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfGOR2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731244AbfGOR2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:28:20 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED7921537
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 17:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563211699;
        bh=9E0ZytSBTx4ARSQXikFxFqt26WTjZZg9YEuzJOE71XY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CvQyWlBHJkYMir6qOJgjnjkTNYuDngouMYZ2nM0oVQkb9xzSIvJe/qiRYXQDXjMPB
         7lVAOCBykBf4qxlzEEPF2ZuEcjSLtiH9TBJOFmQnrCvchgMrQ5KDFopNebDD+yulBB
         qN0sJe/fvbW15UKisT/n89ScJ8kZ0+b1BwOd14yg=
Received: by mail-wr1-f46.google.com with SMTP id n9so18002387wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 10:28:18 -0700 (PDT)
X-Gm-Message-State: APjAAAXYE8mXuhwL5Frgq/gFUNJbBUg/h3RfDWWoaPmEcuHMs+t+Vf4T
        dXokj3ML9cyWNsiEBrRBTolzR+n1anADYUMSKO9Qyw==
X-Google-Smtp-Source: APXvYqz1bcfnUp0J1AeVS+zB00SN2CvvFrutc7PmnWTPZk+ekXhDQO1E9JPmdpKMMm6yj0t8VwFOW7L195SLye6jbF0=
X-Received: by 2002:adf:cf02:: with SMTP id o2mr11075557wrj.352.1563211697557;
 Mon, 15 Jul 2019 10:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190715113739.17694-1-jgross@suse.com> <87y30zfe9z.fsf@linux.intel.com>
In-Reply-To: <87y30zfe9z.fsf@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jul 2019 10:28:06 -0700
X-Gmail-Original-Message-ID: <CALCETrUn=gho5Oug-yYvF2d1WYCe7gvtx+bXuhJ8LTjb9guvuA@mail.gmail.com>
Message-ID: <CALCETrUn=gho5Oug-yYvF2d1WYCe7gvtx+bXuhJ8LTjb9guvuA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Remove 32-bit Xen PV guest support
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Alok Kataria <akataria@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 9:34 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> Juergen Gross <jgross@suse.com> writes:
>
> > The long term plan has been to replace Xen PV guests by PVH. The first
> > victim of that plan are now 32-bit PV guests, as those are used only
> > rather seldom these days. Xen on x86 requires 64-bit support and with
> > Grub2 now supporting PVH officially since version 2.04 there is no
> > need to keep 32-bit PV guest support alive in the Linux kernel.
> > Additionally Meltdown mitigation is not available in the kernel running
> > as 32-bit PV guest, so dropping this mode makes sense from security
> > point of view, too.
>
> Normally we have a deprecation period for feature removals like this.
> You would make the kernel print a warning for some releases, and when
> no user complains you can then remove. If a user complains you can't.
>

As I understand it, the kernel rules do allow changes like this even
if there's a complaint: this is a patch that removes what is
effectively hardware support.  If the maintenance cost exceeds the
value, then removal is fair game.  (Obviously we weight the value to
preserving compatibility quite highly, but in this case, Xen dropped
32-bit hardware support a long time ago.  If the Xen hypervisor says
that 32-bit PV guest support is deprecated, it's deprecated.)

That being said, a warning might not be a bad idea.  What's the
current status of this in upstream Xen?
