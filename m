Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCBCC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD0F20652
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfFYHb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:31:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41793 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfFYHb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:31:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id m7so8337646pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LSFnG1VLPAxdrZu/1aoqM762Ph1wbr10WuLO1iu5MTU=;
        b=qm/y87ecbFyIf1eFZsBSY3h2R6PTNTUomvSbU3uWIfChY+uRq0PvIsQSxBXBsNwHct
         0qxu5Vqc0VLlOUo3UWbBUHa146K1iTtIaHdJRJzPzv7zJqmd9YNwasVX33OnctM2W7PT
         6ED2jEWi/OGGV98Efe3zFxd6GGkOCOm6aqQK17eRipLwROdWt0EK7vjGDw6z26h3/cAM
         2FPfsDcrXaUTkecFh1Y5vseIWUQ+1RdmCo8ap6+xMHy2TgVlzHfFTCHBrpu6isg6J43y
         TxmgSwoIiD0OLyjRbUWTSStYRfbnp/B0QE8CIKuYpZq8YOEm7xfuqwRACVpD6mz8aX5t
         1ahA==
X-Gm-Message-State: APjAAAVifnQo2PwU1b6nO7FM2dkt/hD3v8FIdHJvaxCZyIv5yVaJ/Q/R
        2GyahRL0qu8AAS0QMi7Te04yJQ==
X-Google-Smtp-Source: APXvYqxA3AiKfUdGgybrZGEd+QlSDx5f6SSD+C9TEX69lBm8COreE3lS5uJ/emXNgMIJT2bbhTf5JQ==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr85183321plo.290.1561447885879;
        Tue, 25 Jun 2019 00:31:25 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id 12sm13241505pfi.60.2019.06.25.00.31.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 00:31:25 -0700 (PDT)
Date:   Tue, 25 Jun 2019 00:31:25 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 00:30:40 PDT (-0700)
Subject:     Re: RISC-V nommu support v2
In-Reply-To: <d4fd824d-03ff-e8ab-b19f-9e5ef5c22449@arm.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     vladimir.murzin@arm.com
Message-ID: <mhng-6f11ed95-e3f3-41dc-93c5-1576928b373b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 06:08:50 PDT (-0700), vladimir.murzin@arm.com wrote:
> On 6/24/19 12:54 PM, Christoph Hellwig wrote:
>> On Mon, Jun 24, 2019 at 12:47:07PM +0100, Vladimir Murzin wrote:
>>> Since you are using binfmt_flat which is kind of 32-bit only I was expecting to see
>>> CONFIG_COMPAT (or something similar to that, like ILP32) enabled, yet I could not
>>> find it.
>>
>> There is no such thing in RISC-V.  I don't know of any 64-bit RISC-V
>> cpu that can actually run 32-bit RISC-V code, although in theory that
>> is possible.  There also is nothing like the x86 x32 or mips n32 mode
>> available either for now.
>>
>> But it turns out that with a few fixes to binfmt_flat it can run 64-bit
>> binaries just fine.  I sent that series out a while ago, and IIRC you
>> actually commented on it.
>>
>
> True, yet my observation was that elf2flt utility assumes that address
> space cannot exceed 32-bit (for header and absolute relocations). So,
> from my limited point of view straightforward way to guarantee that would
> be to build incoming elf in 32-bit mode (it is why I mentioned COMPAT/ILP32).
>
> Also one of your patches expressed somewhat related idea
>
> "binfmt_flat isn't the right binary format for huge executables to
> start with"
>
> Since you said there is no support for compat/ilp32, probably I'm missing some
> toolchain magic?
>
> Cheers
> Vladimir
To:          Christoph Hellwig <hch@lst.de>
CC:          vladimir.murzin@arm.com
CC:          Christoph Hellwig <hch@lst.de>
CC:          Paul Walmsley <paul.walmsley@sifive.com>
CC:          Damien Le Moal <Damien.LeMoal@wdc.com>
CC:          linux-riscv@lists.infradead.org
CC:          linux-mm@kvack.org
CC:          linux-kernel@vger.kernel.org
Subject:     Re: RISC-V nommu support v2
In-Reply-To: <20190624131633.GB10746@lst.de>

On Mon, 24 Jun 2019 06:16:33 PDT (-0700), Christoph Hellwig wrote:
> On Mon, Jun 24, 2019 at 02:08:50PM +0100, Vladimir Murzin wrote:
>> True, yet my observation was that elf2flt utility assumes that address
>> space cannot exceed 32-bit (for header and absolute relocations). So,
>> from my limited point of view straightforward way to guarantee that would
>> be to build incoming elf in 32-bit mode (it is why I mentioned COMPAT/ILP32).
>>
>> Also one of your patches expressed somewhat related idea
>>
>> "binfmt_flat isn't the right binary format for huge executables to
>> start with"
>>
>> Since you said there is no support for compat/ilp32, probably I'm missing some
>> toolchain magic?
>
> There is no magic except for the tiny elf2flt patch, which for
> now is just in the buildroot repo pointed to in the cover letter
> (and which I plan to upstream once the kernel support has landed
> in Linus' tree).  We only support 32-bit code and data address spaces,
> but we otherwise use the normal RISC-V ABI, that is 64-bit longs and
> pointers.

The medlow code model on RISC-V essentially enforces this -- technically it
enforces a 32-bit region centered around address 0, but it's not that hard to
stay away from negative addresses.  That said, as long as elf2flt gives you an
error it should be fine because all medlow is going to do is give you a
different looking error message.
