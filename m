Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EBCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0894208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YcdA17Z8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mCdCEyDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbfJ1UJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:09:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfJ1UJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:09:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B46DB60274; Mon, 28 Oct 2019 20:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572293395;
        bh=yDqvNVHhioOXiqjnb4f2q03NmQOz4C5aqZuljuDMOF0=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=YcdA17Z8/z0a65m6GazQEoBEp0Y0FHxyklETaAStgGFT8noyV20xlEJvEBdKpZSQA
         Tn5+YITS2CbbohG1+J2WlWa3PJvR9yENTuoeKFXhZmKbUK/HDUQZfeVtCsn66lpeAQ
         uKtSp2Tjuc/8w1mJPR0Q6cyzsMXX0u0EROCjeyj4=
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A46AB60274;
        Mon, 28 Oct 2019 20:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572293394;
        bh=yDqvNVHhioOXiqjnb4f2q03NmQOz4C5aqZuljuDMOF0=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=mCdCEyDrGyipu0nnGPB7/pULaO1iagaTJbBnIwPaqNbrEjzy4xSUGxTtGbzTYxxoV
         zDzZioBviFtj/O3Vo3pJVC2UTNaeUQ9KaE+0Hu4aB0AoCksBpy6x8gkbGfGCTDdP4L
         1tNTNv5Fr+bmXe+VaH2WFXYI2/wrQUjM+6t4FSjs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A46AB60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nick Desaulniers'" <ndesaulniers@google.com>
Cc:     "'Sid Manning'" <sidneym@quicinc.com>,
        "'Allison Randal'" <allison@lohutok.net>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Richard Fontana'" <rfontana@redhat.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        <linux-hexagon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
References: <20191028155722.23419-1-ndesaulniers@google.com>
In-Reply-To: <20191028155722.23419-1-ndesaulniers@google.com>
Subject: RE: [PATCH] hexagon: work around compiler crash
Date:   Mon, 28 Oct 2019 15:09:52 -0500
Message-ID: <002301d58dcb$a9ffaa80$fdfeff80$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKUlOT6xDYs3glgy2B+THlWPmKFrqXybLvA
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> owner@vger.kernel.org> On Behalf Of Nick Desaulniers
...
> Subject: [PATCH] hexagon: work around compiler crash
> 
> Clang cannot translate the string "r30" into a valid register yet.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/755
> Suggested-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

LGTM.  Thanks, Nick.

Reviewed-by: Brian Cain <bcain@codeaurora.org>

