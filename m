Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34090C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127B321721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrAOKx/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGAStL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:49:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41903 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:49:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id c11so11868072qkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onJe6dugm/eh3u5ymxkdFs06KErcIHwp+V9gxqC9i0c=;
        b=PrAOKx/XcNOBcohT0hQAfOyr30bYhmCFLavIdDXk20F/l4HIfEG5nj6+wOPs6WHxKl
         auXRCuByvA6ZVhAtYiUNdo5ZtB7KUMRyyDPSM+kJ2HQbwVrsJ4dLgXJ6XqO6usSNrkVV
         VVJuhf0NRNDRtmRPmff9BvJvoLQm9oWLBTtYNBMmFyssCzImCgW6BK+p1TVBiduf5N84
         5++uu7rRDYSIWdJhNJG3MRjgpEv4ShUTToGAN6j61yz4f2FBzp71mYAeRRuSh88jxhFT
         xemzoqYcvh2Aofqnn5/+mU7bYDZ/Q2VqzVdR2+t+Tj1p05Dz6z7Ed8hiidWdqsxk10T7
         94GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onJe6dugm/eh3u5ymxkdFs06KErcIHwp+V9gxqC9i0c=;
        b=KuLM0QrRXIkb+0x73zFTjylnppOoLrlXNf9n6DzoWZdPM8l/ARI/ZK/SrSIr8q0VMx
         HGEG1T5eqLApn6B5sF13hJkHc5lukYq6xG5tEeKQY5Zx+lI/m4MqagsOJ4voBoYisa0d
         AZZgfRp5EiUO8yrxa8fxlArO/jhRREwcclYcHyIu7434fxxiAKEldA5mD9+56WXm0VvO
         nY8wQm4xRCrAPA2a+uDh9CEWV8Mw4VORBtlBmqVyb+7ng03gxEsfObgdmOKHCYDBet0Q
         6AF1nMkr7829ciQT54XRkiarnUcbXZaqKhK2+R7+Y3k06BWWcYEqtMRH7HcyKI6lWcet
         G2EQ==
X-Gm-Message-State: APjAAAXCSRBx6B0CegxwHqf3gKF/ABB/P2LhyzJiSCx68aYCts6X45OH
        isQ4F4TpkPK8XM8/a5pdVvhGSnn6k3Q19sx9uuhwj8hB9ng=
X-Google-Smtp-Source: APXvYqwWnCMIxXVuRreDvcVNzNNoZyG288LSyiQ+/bNv7cs2p9ghKPdfns5hkYEHWm5ctyKxNbbPoQjPnRM02dP/1I4=
X-Received: by 2002:a37:a10b:: with SMTP id k11mr20459116qke.76.1562006950089;
 Mon, 01 Jul 2019 11:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190628193442.94745-1-joel@joelfernandes.org> <201907020214.bB70pmmk%lkp@intel.com>
In-Reply-To: <201907020214.bB70pmmk%lkp@intel.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 1 Jul 2019 14:48:58 -0400
Message-ID: <CAJWu+oqGC5oDqyRVUxYZ-XN4qJPaaUNbPqa5hapox4m9=17iSw@mail.gmail.com>
Subject: Re: [PATCH v2] Convert struct pid count to refcount_t
To:     kbuild test robot <lkp@intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        elena.reshetova@intel.com, Kees Cook <keescook@chromium.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 2:47 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi "Joel,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.2-rc6]
> [cannot apply to next-20190625]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

Jann H was faster than the robot in catching this, so humanity still has hope!

Its fixed in v3.
