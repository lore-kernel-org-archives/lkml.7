Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA132C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A02221783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSG6cZwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKKOWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:22:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39231 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfKKOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:22:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id p18so14007510ljc.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Q6Ic4KHmL2oPLqwtq9oO2+Aaxq9lOPnDyaM0GuYG2s=;
        b=tSG6cZwTtukcRbi0eWqvq7DsBDFbFCmFCycdd3bvXfB330J8jnwEY7rnaqH+QvOQhq
         eBqdU45xQm40U7dcNo5iOp3DFWmZE9KIJfYrPxUpAAAzd+W8vJUZR9WO77NdTj8ms9Dv
         GeZhBDpleHJtZmIwtsuJg4dERBUz7nzy//j8d6dDN9SiYCsCcIKEcrfvyMpT11NlP3JM
         e9nwqiM8WrotCAvlD8b5bY26WrZm2YihssZatloCz+sY/IkHUAQn5uEL5WjJbHciAIJq
         B94uX2vXQpNUBLcrBbmL5GmhWKLo032BP3kcyxs37uPIb3NQxxU5YxC17vhgwfiRR6Wl
         dAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Q6Ic4KHmL2oPLqwtq9oO2+Aaxq9lOPnDyaM0GuYG2s=;
        b=KGJxHw/GXWlw7LE6js9GBeuo2BYad5DQ2eMN/HO4rLIH+NjQnTieG0Br+uwhc0X/T+
         2dj8HVPXpd908GXJX/1X8w6e9j/G/6POkr5xv6Idw06xQHxQhNJjya11xzWF3cAbiL1B
         Ya9Q7/H2L7TxkI0Eh47ZglWf79Ue5gh0AUddEQAM95+p4DfzCuzy20C93r8ygCscHLXx
         WHWxahV5FUxNBlZayA1JUBPFb280nYTAkoWLtNFYPNZpHVkK1WNJkC3Bn9LEktfv96lV
         mvc4mAh1qZWCeIehYPWTA442FNYHgsuTHcJy79nZJnvfI3FkBEqTuAWuTbAJlcoUwTUL
         q5+Q==
X-Gm-Message-State: APjAAAUmSNjRpCEWixUmERKgq69Xu/f1c20/nEYyAJ0dzwHCDgtav9So
        5pyt9DWmdU8MWBp6B/MueZQ7zdV7aGCiLR8ekAnPXA==
X-Google-Smtp-Source: APXvYqy2MkTs4zJnjZqb4OH8Xuxf9ZqN/TQMc4ey0G7YfcEEFe7Wou5fJUTTyGh7rgcPFJZs7XDxwut1mDuZPxufmIU=
X-Received: by 2002:a2e:b163:: with SMTP id a3mr15817576ljm.72.1573482162152;
 Mon, 11 Nov 2019 06:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20191110092616.24842-1-anders.roxell@linaro.org>
 <20191110092616.24842-2-anders.roxell@linaro.org> <20191111124501.alvvekp5owj4daoh@netronome.com>
 <4ce79d06-e8af-6547-240d-50e3038a6ae7@iogearbox.net>
In-Reply-To: <4ce79d06-e8af-6547-240d-50e3038a6ae7@iogearbox.net>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 11 Nov 2019 15:22:31 +0100
Message-ID: <CADYN=9KHgAq5Birmba-imeZeFtgQW=d_EVzh5p+h74fxv4HRew@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests: bpf: test_tc_edt: add missing
 object file to TEST_FILES
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Simon Horman <simon.horman@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 at 14:01, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/11/19 1:45 PM, Simon Horman wrote:
> > On Sun, Nov 10, 2019 at 10:26:16AM +0100, Anders Roxell wrote:
> >> When installing kselftests to its own directory and running the
> >> test_tc_edt.sh it will complain that test_tc_edt.o can't be find.
> >>
> >> $ ./test_tc_edt.sh
> >> Error opening object test_tc_edt.o: No such file or directory
> >> Object hashing failed!
> >> Cannot initialize ELF context!
> >> Unable to load program
> >>
> >> Rework to add test_tc_edt.o to TEST_FILES so the object file gets
> >> installed when installing kselftest.
> >>
> >> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
> >> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >> Acked-by: Song Liu <songliubraving@fb.com>
> >
> > It seems to me that the two patches that comprise this series
> > should be combined as they seem to be fixing two halves of the same
> > problem.
>
> Yep, agree, please respin as single patch.

OK I'll respin it to a single patch.

Cheers,
Anders
