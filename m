Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD11C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3802133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfFZMTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:19:34 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40268 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZMTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:19:34 -0400
Received: by mail-wr1-f42.google.com with SMTP id p11so2484720wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z65EMMRLMdv1kWvP14/NVwJOwEpNkbLuO3J31367Rxs=;
        b=WQe0ytc5qRTha08dO7dhjxvhIqquYazR1QjuXcy+KGkXODf+r8TDjD/ur+ZCQF6YPk
         WnXZcPEn7hSh+tvSp5nXE07CIoPqm2sIr+lLadlmD2rTfhyFM2BiGJLbsQz3ohTdBhSH
         a/2unEHCrhjDVYbrOD/maEoFYSCjjXHqA4absb6FdC3kSEiC8s60Bgm5S5TgQEDu60+5
         fIS3qxoeyjDtgbMuHk4oAEzYMXi4M9BvGoETIZsqDHVuaOcnlKkrKBMHW4zPS2o1ikNT
         Dy/gnxb95CTQ9G6eA+rGagCvpJfVczB22OurOg0OdfVjGbOoZPlpjw8w8P5Z8cj0N9C9
         KDQg==
X-Gm-Message-State: APjAAAUrTpgO1hVBtMS1cN+LGNEVgBIkIJiphuY1GFxm7AfEiHybe+l6
        kFyjP6aW7k92cGjrr1nf2Fq9Mg==
X-Google-Smtp-Source: APXvYqxjVWpVZIPguHFdWiP8rPq1t14VjoshpsvwLkCTn21s39Idea2oHCjm9hOtTdcLHbRSD5BINA==
X-Received: by 2002:a5d:4b12:: with SMTP id v18mr3611195wrq.123.1561551572292;
        Wed, 26 Jun 2019 05:19:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e88d:856c:e081:f67d? ([2001:b07:6468:f312:e88d:856c:e081:f67d])
        by smtp.gmail.com with ESMTPSA id j189sm2373028wmb.48.2019.06.26.05.19.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 05:19:31 -0700 (PDT)
Subject: Re: WARNING in kvm_set_tsc_khz
To:     Alexander Potapenko <glider@google.com>,
        syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com,
        haozhong.zhang@intel.com
Cc:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
References: <CAG_fn=VyAYUYJuCqR1rL_KjGm5i1mBzffA=uuCnTa0QOBRsvaA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <abc5e09d-aaf5-3e12-6f2d-d97138951abe@redhat.com>
Date:   Wed, 26 Jun 2019 14:19:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=VyAYUYJuCqR1rL_KjGm5i1mBzffA=uuCnTa0QOBRsvaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/19 14:09, Alexander Potapenko wrote:
> Hi Haozhong, Paolo,
> 
> KMSAN bot is hitting this warning every now and then.
> Is it possible to replace it with a pr_warn()?

Sent a patch now---actually 2 because I forgot a --dry-run. :)

Paolo

