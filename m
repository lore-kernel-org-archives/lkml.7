Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884DCC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D77217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BqBbqn1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfI0QCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:02:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42375 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfI0QCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:02:07 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so17577600iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgAkk/YaVOjIm+eYoirnfpTGVi4GTRsy5eJmu7zQ35M=;
        b=BqBbqn1v6BmDj80XgHueQfDT2g8OiaP8+NPPh+sl4i4CnrYqtnxxdv+h6I7Q2C/l2T
         Saadv4tE19a3iwbCVOyoYMs8noKK7KGUyPU41lJJUD6xE1/gs636wHaX+QqvZP4j8YrA
         YEQOvkEvhfvstBudhmys/ZpKCjB06Czqb+fy4qAUadsv5jUvHi13iiuYFjpb699KLAi5
         8dA31ACK1Ua/zfUNHwskFeILW39Db9V1gqf4MD7bWzc0V2lrrC/fKeZjq+1Qke1k4Ezn
         HhopI3/wC618fZErDUxFx7lghzYwYXSNM/v0E5UpzuBY4rOyXDmIs2Sgui8mPeo4uRZB
         XQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgAkk/YaVOjIm+eYoirnfpTGVi4GTRsy5eJmu7zQ35M=;
        b=msp33btZlgEzI8ZQJg2XWqFaNJFvggPJNswWxHU30hECzGbb7mOguhX4XT/iVy9Jzq
         aqHJZTCJd4fP7Stj6TZBwfHwO7CycxDCmVR5fJsL/ha2yk0x90zl5iNTPWkbVFGLgurd
         bjSqfoUuz4kYMLa29w4XA1FiSwwbHohK3iYy+OpofdP6k/OJLONuu2zXxBWM49HtJE7j
         La1m6iKqYQ3T/OmJ3G71ZQDhdbqxbhKmK57u6vXQ3fpl5JZ1j+cmPdsvjnOruDh1ZPcq
         bHBCbOiucQfoDnuXMhtaHpiB/mf3KVdD0WRlc9hKZ4qySvgRVMtnW8IkzFG5/Kypeqxn
         T2dg==
X-Gm-Message-State: APjAAAXmw6oCdzB6sOoFU1sB0TeMbI+5CfP+mNu3QzOi5KNychveSSZd
        lcBm5SPa9259pcY75gigcFIDlc4HJ1150dOcHaNcbg==
X-Google-Smtp-Source: APXvYqwKBik3py7QHelQi1j9yqNr6X9seM8w1k1A2J3dgKRVd3txN4UH++9q5EB7yTpsxrY2YTVnE7EV+rNZJ4Of4ZI=
X-Received: by 2002:a92:4a0d:: with SMTP id m13mr5429319ilf.119.1569600126204;
 Fri, 27 Sep 2019 09:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190927155413.31648-1-vkuznets@redhat.com>
In-Reply-To: <20190927155413.31648-1-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 27 Sep 2019 09:01:55 -0700
Message-ID: <CALMp9eRRavuTr44XnL-ySWy7B5=Dir1Vt+oMp1+EiFbpNy6Mig@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: x86: clarify what is reported on
 KVM_GET_MSRS failure
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 8:54 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> When KVM_GET_MSRS fail the report looks like
>
> ==== Test Assertion Failure ====
>   lib/x86_64/processor.c:1089: r == nmsrs
>   pid=28775 tid=28775 - Argument list too long
>      1  0x000000000040a55f: vcpu_save_state at processor.c:1088 (discriminator 3)
>      2  0x00000000004010e3: main at state_test.c:171 (discriminator 4)
>      3  0x00007fb8e69223d4: ?? ??:0
>      4  0x0000000000401287: _start at ??:?
>   Unexpected result from KVM_GET_MSRS, r: 36 (failed at 194)
>
> and it's not obvious that '194' here is the failed MSR index and that
> it's printed in hex. Change that.
>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
