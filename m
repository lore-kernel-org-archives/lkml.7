Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B57C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA397218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562277099;
	bh=liSwsfTSayzcp2ggNxY8SpsNtsP/R82WSTHXE3qSnX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bB0R2p4LwW0aZVN4RnNmK6CTKH3NMxa2fnTWS35pa0CYQozuam/A8Ypi6APJ6SAXO
	 FAf3PbCDqhr3Wlh2+gh3hJSV471JGiNQYh5a9g8FIBinvMeMBd+vvKnkGhvrwWifNo
	 E+uzUY/1HkvngeMEHwfvJMifxxcfiK4u99UjfvzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfGDVvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfGDVvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:51:38 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E8AB218A4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2019 21:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562277097;
        bh=liSwsfTSayzcp2ggNxY8SpsNtsP/R82WSTHXE3qSnX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vFk7xX3xJgAmnCaWxV2a3RV1XJcV7Z2Ko1uW9/FvO0Js01ECyQDBddt6Jbqt8Z60U
         2Iqg0UYlDqYoh+w2U7l6wf2bcfxrFW6Z0BnuDghfNWGtaTiPs1UFO2vXYczJEPeOWE
         cF74tobslhTiUp9hP2JQwT1gJUOuGDOLyKVG//cA=
Received: by mail-wm1-f46.google.com with SMTP id x15so6915860wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 14:51:37 -0700 (PDT)
X-Gm-Message-State: APjAAAWAnBsH9QGImJa37F07thp5RkXf210rjXVfsh/Yc3BvTk5rRRAe
        6D3KLVKQ0TFs2E1BVlNCX6l3AnBZ6wD7bjB0N6/2Vw==
X-Google-Smtp-Source: APXvYqyhn+262OX1Iq9+G5Nwv/UfGnqwvHaL/MSjTI7g/C8jTkKJrelpAA1ljt2D9DmHuAZB5zNMm0fDtmjOoUjtzLs=
X-Received: by 2002:a1c:60c3:: with SMTP id u186mr111249wmb.79.1562277095718;
 Thu, 04 Jul 2019 14:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.363747790@infradead.org>
In-Reply-To: <20190704200050.363747790@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Jul 2019 14:51:24 -0700
X-Gmail-Original-Message-ID: <CALCETrU5ZOi87Wp8GpnPuZxEr6u2LL45eomCzgd9fKXOPkO+EQ@mail.gmail.com>
Message-ID: <CALCETrU5ZOi87Wp8GpnPuZxEr6u2LL45eomCzgd9fKXOPkO+EQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] x86/entry/32: Simplify common_exception
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 1:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> By adding one more option to SAVE_ALL we can make use of it in
> common_exception and simplify things. This saves duplication later
> where page_fault will no longer use common_exception.
>

Reviewed-by: Andy Lutomirski <luto@kernel.org>

Although I'm still looking forward to the far-off magical day when we
decide we can drop 32-bit support entirely!
