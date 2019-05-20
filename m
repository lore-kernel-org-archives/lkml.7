Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA40C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A2A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA+ZjDiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbfETLgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:36:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35195 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbfETLgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:36:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id n14so12661953otk.2;
        Mon, 20 May 2019 04:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYKgpm1NW/AEu497K47vi3qUNsDgBwJgGMZFIkaRyMg=;
        b=lA+ZjDiPZJ2CZVw1XjRn0/jANWPRUrsJdBVluiAyCOhBKfG/P4PFg5C7zTvulV62aq
         ZDyb6XMMfe3RciCzFc8m9up7j35GwmjDeWfIStOmX+0wkCEGN5HRafDtzUsga5aDE2f4
         hTODAbqF5+kEpSvz6o3Ys27HoLYmDSfPgCThssldgX77NfLvjdzfHUSinn1f5r0cC3p0
         VbgqCxQUaPaa5EefWDIrr7JJVR1PRq9RepZCjxywzBzrfcFo25O4oO+Q5DUt5li76YWL
         oSFdeTnZF7HSs67rurdZl/ljomNvUtahGttN+w1fidkK3y8g4tfg3fMAQ5BbafaYia6Y
         UK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYKgpm1NW/AEu497K47vi3qUNsDgBwJgGMZFIkaRyMg=;
        b=RTBww1UoSHICxzzua7zTB/nK/4jPQc4MJNMz+djsvGWVPoPG2BmPDDqEiEz0LDpjCk
         Yh7hHe9zv6SiMi2MVGuLYwU+2wS/tefobB6ET/ZW3ulxorW+UW4M95odXmDPRTp0LUnH
         ZlTOOCwfWwS1EnVeHyCVt4uoNFsdqBP47vKvS/K+21WGvWj6Uz79bwSYGuyKNC75bpL6
         4b+zdz77zYvlTmnf5jmRR6150pCs+66FvBHw2i3G1lxj9obTZDp3yjK6lotk00fXnm4S
         pXUSBkFhZtsredMjPFqWZruExMlB9g05IFY2Bil4bLEgmI0CacB0AyccCT2dyhZvE/h5
         KJMA==
X-Gm-Message-State: APjAAAXsdto5hKGsGMtvTwPL0OgI+WNSWDcjpojggUZBLPnnCQPlb+G+
        3JjcHK+RMAsNtHH2O7M164tInD9GRi+C0SfT488=
X-Google-Smtp-Source: APXvYqy61zi+V498WQ3FqLdONnpg7SFfQMBTf7Gg3cEi871xFOXNfayrSfkUXZRT32gvR5j4wql+guNN5876drs7yKc=
X-Received: by 2002:a9d:6312:: with SMTP id q18mr3636712otk.45.1558352209285;
 Mon, 20 May 2019 04:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <1558340289-6857-1-git-send-email-wanpengli@tencent.com>
 <1558340289-6857-5-git-send-email-wanpengli@tencent.com> <b80a0c3b-c5b1-bfd1-83d7-ace3436b230e@redhat.com>
 <CANRm+CyDpA-2j28soX9si5CX3vFadd4_BASFzt1f4FbNNNDzyw@mail.gmail.com> <bd60e5c2-e3c5-80fc-3a1d-c75809573945@redhat.com>
In-Reply-To: <bd60e5c2-e3c5-80fc-3a1d-c75809573945@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 20 May 2019 19:36:40 +0800
Message-ID: <CANRm+CzFQy4UC9oGxFK8UVVhdtV_LGeF3JcNohpRcgspSqcxwg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] KVM: LAPIC: Delay trace advance expire delta
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 at 19:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/05/19 13:22, Wanpeng Li wrote:
> >>
> >> We would like to move wait_lapic_expire() just before vmentry, which would
> >> place wait_lapic_expire() again inside the extended quiescent state.  Drop
> >> the tracepoint, but add instead another one that can be useful and where
> >> we can check the status of the adaptive tuning procedure.
> > https://lkml.org/lkml/2019/5/15/1435
> >
> > Maybe Sean's comment is reasonable, per-vCPU debugfs entry for
> > adaptive tuning and wait_lapic_expire() tracepoint for hand tuning.
>
> Hmm, yeah, that makes sense.  The location of the tracepoint is a bit
> weird, but I guess we can add a comment in the code.

Do you need me to post a new patchset? :)

Regards,
Wanpeng Li
