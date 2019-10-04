Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABF1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C2A222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVq6fcbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfJDX1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:27:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44856 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfJDX1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:27:07 -0400
Received: by mail-io1-f65.google.com with SMTP id w12so16992913iol.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 16:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgBtF74uU/h5axnlk7JkCOLmu+x1dOiph+vzsmYmvXk=;
        b=uVq6fcbrUf2k6Z02rKXUYQfm+NxJ2X43dktUoENxNfmYB2XHRk95SxYzgRSsUxbcrB
         VMY+k9uQhD+yw7Z86iccSLyRvIZnFRWINVLQMCAnizvTboxDa8tSgunhpBqy399TufJo
         pTQgwsr0b4UWFteBOPGCKp4iaOAJbfAmgi0akHoXxFyE+3Odreox81GbAtjlHVpI3px2
         Vbo5DzvIn0o5B/YPL/oms2GZI0hF4ZHLN5W6SagkqSMqr/NrriKUAizDRFMfuWBMfg3o
         h5rMM9AS6TZh1Fjlyk+8lgmSMuV6Io0A48BTiKiatBflNxygHw3HopbT40WTIM5nuhhh
         6BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgBtF74uU/h5axnlk7JkCOLmu+x1dOiph+vzsmYmvXk=;
        b=KDDliHn5pcBsifpacGB9hR0tUKwfNHgTm0EC+rCH9lmtwETOScwSK1YKjZxL/x6QGz
         7xLEKQAXbmSIspajFj647I+qLVpBb5jNd57jnYcMy2DKYImEMvTZ2X/Krr3nT7Pvpcwz
         jh+/d5s3ula5OK3OIwzzu7OfM1ZeU9dFGHmXlzWZnuWPVvp5dvoy9p3OYJoN7WzdMIvc
         HfuOg+/eLVM1CKEaPE+dkZqnf1HKgOYv7Lwx1/C4mH80SbgLlWN9Ugt3PgeMnuTknVCs
         YJ2V18QtNt9+4l7t7H7yxRtvwJWWkVw+qzEEWuknCXjw/JQeyUtuZPhqu3QUViiqOtTD
         hntA==
X-Gm-Message-State: APjAAAWa3Ge2HmmXFim50sRWjSOhXslJcGdG2BKUixz/NVhNqip+TI1I
        iY4x727F1CTv9Vhy7HXQA8NgqkQSh16ibv6B9L04QQ==
X-Google-Smtp-Source: APXvYqzJcQzvaX5CC41I1TRQRNaPDPcG28y+blJrc8QdeTRZXOhchbrBqUvMeJR9kiv9S7ucRVxFUERN4ZPen7d4jzw=
X-Received: by 2002:a05:6638:3:: with SMTP id z3mr17415762jao.54.1570231626712;
 Fri, 04 Oct 2019 16:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191004215615.5479-1-sean.j.christopherson@intel.com> <20191004215615.5479-8-sean.j.christopherson@intel.com>
In-Reply-To: <20191004215615.5479-8-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 4 Oct 2019 16:26:55 -0700
Message-ID: <CALMp9eRDxHAAbtvdUZyM2VyKiKhRxftW+zbmGANF6Y6qADK9_g@mail.gmail.com>
Subject: Re: [PATCH 07/16] KVM: VMX: Use VMX feature flag to query BIOS enabling
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 2:56 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Replace KVM's manual checks on IA32_FEATURE_CONTROL with a query on the
> boot CPU's VMX feature flag.  The VMX flag is now cleared during boot if
> VMX isn't fully enabled via IA32_FEATURE_CONTROL, including the case
> where IA32_FEATURE_CONTROL isn't supported.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
