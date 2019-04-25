Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058B8C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0FF2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRqZYwTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDYL0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:26:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40003 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfDYL0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:26:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id o16so6402685lfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 04:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:openpgp:autocrypt:to:cc:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=7n+73XXcQJZoFiwfDZaSuSkC8S2rR3EJ/z9Q9rUuu5Y=;
        b=ZRqZYwTQG160ejBtsZbP1yhFAEQXXacKXw2CwoMUoalFX1HPcidO7Z3IwtM9joPluv
         LLTHIA+n3x2F63Z4Mzew5dtZdMPqyRTabhRK6kiYp+PRk9anezrNZHH/aSsWV/Vgzq2A
         0iVBCo4SrcB53ALkYVCA5KIfuGgTxaExIkVI24dewe55vhGAZ+9I4uogOKrlCGzF5OOt
         DVfjq2r+rp4iXVxqGTb3Ah1n97YbnJbjq27GkkbdsSvQ12OHxGO+YboeNrJxorarRF5P
         zXytICVEuxAf+xmYcP5DfLXc//VcB+kH8Th4wvHQb4tRxNii1zmQfEJi/nMJuziWPPVH
         lggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:openpgp:autocrypt:to:cc:message-id
         :date:mime-version:content-language:content-transfer-encoding;
        bh=7n+73XXcQJZoFiwfDZaSuSkC8S2rR3EJ/z9Q9rUuu5Y=;
        b=h/VwIsC1QmBuwB4pvIsX/yhUtooyFAXZ/g/MyCj5YoH/qs+QhLvSu7z86hzVyxA2wa
         lyd7fzhSebeoWCF99q63kR5bZDbpdK9iOPzInfoUgEID0F65LTpU2ZudHEf9tQ08MspP
         N9ZcrOWdIp3tgcUTAB26U9fTa5LeZfbWgaVhs6av16/99feM8gk88O0Kpj3eeJmlVcJd
         uhBiJz+QCjAuS/Tv5vj1q3NYjDnVpWCal8QmpeGZcgrGscCaZxYUcdTIB/unvW2f8pIU
         uq4/SFoQAsXa1fj86kaHbhw/bHFnstgx5VwNnD2ZMdCY5j9bp3S08vp5d26LXWTxVbQq
         FIZg==
X-Gm-Message-State: APjAAAX3oSROtp1+/QxtEWgSY4T+rj3r6Jus38hHssgxB+rfZd6ffbV+
        PbGdkKJojQZ6WxBU0DMUICKb9GurK1c=
X-Google-Smtp-Source: APXvYqwx94+hAungFBnG8L/s/bOBzQwUgIe3GaiU/CZDJr1OJlCr+b6pJELhJERaSe0L5AFvmzJE1w==
X-Received: by 2002:ac2:5107:: with SMTP id q7mr20419380lfb.162.1556191559594;
        Thu, 25 Apr 2019 04:25:59 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o17sm4517043ljc.66.2019.04.25.04.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 04:25:58 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: [GIT PULL] interconnect changes for v5.2-rc1
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <eafe23a5-e3cd-760d-f3f0-c82b50e78417@linaro.org>
Date:   Thu, 25 Apr 2019 14:25:55 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is a tiny pull request with interconnect patches for the 5.2 merge window.
The patches have spent a few weeks in linux-next without reported issues. The
details are in the signed tag. Please consider pulling into char-misc-next.

Thanks,
Georgi

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.2-rc1

for you to fetch changes up to 83fdb2dfb0c2925f253449677830ed11461ac5c8:

  interconnect: convert to DEFINE_SHOW_ATTRIBUTE (2019-04-06 22:03:03 +0700)

----------------------------------------------------------------
interconnect: for 5.2

Here are some tiny patches for the 5.2-rc1 merge window:

- Add linux-pm@ as a mailing list for the interconnect API.
- Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Georgi Djakov (1):
      MAINTAINERS: Add mailing list for the interconnect API

Yangtao Li (1):
      interconnect: convert to DEFINE_SHOW_ATTRIBUTE

 MAINTAINERS                 |  1 +
 drivers/interconnect/core.c | 13 +------------
 2 files changed, 2 insertions(+), 12 deletions(-)
