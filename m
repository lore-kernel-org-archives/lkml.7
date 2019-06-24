Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79751C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ECC20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561405747;
	bh=YS7krK6pwOnDCSR2Dz5EYSKEqmWSoCDbfsVQV5IxsSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wxDGoeHFrBFklkG2CduVfmt8PxpkqwZ68kGSKqn5vVnJyW7xZuLm/mzzWTgmIGOPW
	 1GdEOpVEgIgN+AQCpkyyJ1jJlC4U7430jXQGfWItWh27VTrgJ7vKswV3988Eme1GOA
	 IUDIWL/OqebNZonlZ3MpSHBlKHq8q8ABWY80g+4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfFXTtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:49:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40844 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfFXTtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:49:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id a21so13798494ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0QcUYzpRrkg9pWxPfvUVU3Rs8HMzzByn0cblozJ9x0=;
        b=R7WMJ8FHrch3Kl42vaN6VjhTyL4k7RQ9YSaseThbyq4jINbU5qdWjzaGkplY3mdIio
         qMjxnZt0sIL/vKJi9ZiNJXVRRzVUt9Z4hTOj9MP/KrrV32zZbe8bAD8mT9qtRcAB+zcP
         rBYdvXUiBVcKEI6yFepafKp3F4gukJf8pqFH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0QcUYzpRrkg9pWxPfvUVU3Rs8HMzzByn0cblozJ9x0=;
        b=CGJ1P+3R2kzvi7QC8xdlToouWjy9uoPloDSRp8b8qq5l8TB66TZBbfS00zyGeEcaQs
         C+YPmNSjdaesUVfmfEgYnVcDM4zrAWTWrx0kQB2GC4hjmwMtJTVQuAX5PDzm0z2DvGDU
         t8284y8M4ExgRopkvCYrK9roah+uNNn5zp7fMJ9tN5PQKJ5Nyt1COoUgORV5jUj4fUiw
         ygFgBBv+x7ux4F3dFjKVIOo9SzD0SrXBjBqIS8+ZTNAgAMA6r6A6X7UF7lhhqP4NMJrS
         PX06Zqw0X1OQE5K8k9m0FGZtTS/VLurGPoX5YZT0v3U3THu4SpglPyGY4A90Q0wBrvSE
         tiVg==
X-Gm-Message-State: APjAAAUJsjKreB3CfTs9zD7uqIdW2mO93UGagREmXlJtCLoxfjn6kVNe
        Rift0/xrH3v9IiK8aRFQJ9mfN8qJqio=
X-Google-Smtp-Source: APXvYqwtafdWpvP0XTJrwMxDYYbVSlQonjI/bEh6QK5EEbYOmWjT0r93li40Uj6ws5q7WTxmWc+h5w==
X-Received: by 2002:a2e:2993:: with SMTP id p19mr53220336ljp.202.1561405743303;
        Mon, 24 Jun 2019 12:49:03 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t4sm575348ljh.9.2019.06.24.12.49.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:49:02 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id x25so13837070ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:49:02 -0700 (PDT)
X-Received: by 2002:a2e:95d5:: with SMTP id y21mr64392011ljh.84.1561405741968;
 Mon, 24 Jun 2019 12:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org>
 <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org> <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de>
 <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org> <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de> <098de4c3-5f71-f84d-8b49-d2f43e18ed91@alvarezp.org>
In-Reply-To: <098de4c3-5f71-f84d-8b49-d2f43e18ed91@alvarezp.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jun 2019 03:48:45 +0800
X-Gmail-Original-Message-ID: <CAHk-=wgwKVnod6a030iRDWTbkV_no+ggRzMUFAws0iEbYe=jqw@mail.gmail.com>
Message-ID: <CAHk-=wgwKVnod6a030iRDWTbkV_no+ggRzMUFAws0iEbYe=jqw@mail.gmail.com>
Subject: Re: PROBLEM: Marvell 88E8040 (sky2) fails after hibernation
To:     Octavio Alvarez <octallk1@alvarezp.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 1:08 AM Octavio Alvarez <octallk1@alvarezp.org> wrote:
>
> If I boot regularly (disable_msi not set) and then do modprobe -r sky2;
> modprobe sky2 disable_msi=1, the problem stays (when back from
> hibernation, the NIC does not work).

Side note: some distros end up unloading and reloading modules over suspend.

I wonder if perhaps your system does that, and then when it resumes it
has reloaded the sky2 driver, but without your manual "disable_msi=1"?

Because it sounds odd that it would work with the kernel command line
but not manually, and so I wonder if perhaps there's a hidden module
unload/load that causes that second case..

              Linus
