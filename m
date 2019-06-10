Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3C1C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5327D2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ijZRqYOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbfFJVct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:32:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36077 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389760AbfFJVct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:32:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so145005pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u65kJhZ2c0w54Nc/i9RYT+l58N6im9e9Q29G/YH/uuc=;
        b=ijZRqYOHAJLGYs5vVBH7AyvxnX3poiS7Ze8fMa8xMMZFUFQkNHIHUJuCZa0E+HU7KK
         ZEEdHPDvfDlVSbqAvrXP3rviz6pH3j9htRBPT5NIqJKjGJE+FjxllNFI8RlkWV1QA19g
         aArbTyQM1D+rcblnoPAFTe/gzDozuxJ5mSkQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u65kJhZ2c0w54Nc/i9RYT+l58N6im9e9Q29G/YH/uuc=;
        b=uSZKdgKa6VedztE2ODM+Q1jrhkKaTWJF4i0JGPx/0m4OYZNb3RC2PTtHNYrtTAqYEf
         T6mnouYbBmUg9xIqJBy84J+PoAqLs3D+H9hSYHf0D/bbOYvfMEwdg0j9gCTbyoMxZsJP
         6Ao/CQuoV2YF5Vy/vvwtSK8Jnu0MC8bBper+h68+iGMvZ6yOzDwpOoP75ve/6tmBgOrV
         U3TJxoD8Uri+4kxYqMPjCxGW06nTx4yiDyYPS0AcTn5Kaz/ubz4m6AgYK+XWVireDNer
         dOtwg0vznBTJMYbhQ5/d5gtrgl6V44LFz2KRSljGzeN/JdyY+9wCYaAz0MoZSODIQItP
         g34Q==
X-Gm-Message-State: APjAAAWHqh/d88/JkrAjwQtmfSgPjMvWVwVqT9CINBKclYyyAxjGldhq
        nHv6z5SnxyqPzCAE3lHeUoyh0g==
X-Google-Smtp-Source: APXvYqyQzwsz4g4vXj8Aq9NRG67WJeqq4COKYtOvIJxo3DWxXcQEhMnNrnrMg8J5OGqUXm+tPqrSlw==
X-Received: by 2002:aa7:8145:: with SMTP id d5mr77831178pfn.11.1560202368916;
        Mon, 10 Jun 2019 14:32:48 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q1sm18907954pfb.156.2019.06.10.14.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 14:32:48 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:32:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>,
        Jan Beulich <JBeulich@suse.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 00/12] x86: PIE support to extend KASLR randomization
Message-ID: <201906101432.B642E297F@keescook>
References: <20190520231948.49693-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520231948.49693-1-thgarnie@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:19:25PM -0700, Thomas Garnier wrote:
> Splitting the previous serie in two. This part contains assembly code
> changes required for PIE but without any direct dependencies with the
> rest of the patchset.

Thanks for doing this! It should be easier to land the "little" fixes so
there's less to review for the big PIE changes down the road.

-- 
Kees Cook
