Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C841C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A9624621
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETzhMp4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfFCWC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:02:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34762 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfFCWCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:02:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so3147819plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OE+DV1iDnGanqSUQ3gSDQa7SpBzGqjCR4U6alQ1giEk=;
        b=ETzhMp4AEe8Flmgo/kSIOHAb7In2pkCCzlaZrVqjGS9VomKBpb1Ew6hcj8mmKX5knn
         qGoou8mTUyHaPd6kEBiCAvMFFqs9xPDPAahfq2DISXT7b3tUfemptyic2Dfi0t9BpdxU
         F1j3aJwvPscd/wm+FgfdySro9d9yOzeALIWESgnLEF5tzpnxDb2/J7Pmfzvivo3Be7Xf
         UBUVP+ncVzuScyUppESTqcypqYa4JYtDfPpuKlBTvwzBSTFHthCGJDOBUB/d/qalXVgs
         nCETrnR6yqwNkehtkPxHB2rObaxAN8vz1FJTz7TaCD84ah988wtYkhqREBsjw4zTgvvw
         Nfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OE+DV1iDnGanqSUQ3gSDQa7SpBzGqjCR4U6alQ1giEk=;
        b=WBzHYp9rj5pCAJcw3czkYoTxpvq13HJu1HrOarjcSWfuoVGkzxADPxotr5xtxQQEzH
         skHnlGX8qn0/HKAX2xzXzUfKEUSZitwpjD6/z6L0XsFjGd/Ce3WOup25MTkTSEnaihmM
         f1EiwgIMPCULxGwUpuQbfIrQoQPVzlSBoAr84kgvfAgIyYJQk1itFxXOMtLkmU2OvcsK
         wMhzBYmGUkZ4VMCWS7Lca8g8/y9DBsTW7fve8c+boVHuQdrq0UW5hNj1qMhsSB4mdWfy
         4n81EfeZIn47HGtwsZs9GUnFiKecKQFLGc48NPj0R6scP+mXvmyU5XDXiIx1ZLJG3PYa
         ygyg==
X-Gm-Message-State: APjAAAVoMVVJ/rxM3oKrrT3+J/AidsDKPRHCw0fODbHBs024f43tEh3g
        wSt7rYB+MGQxQG6e5OT5gWMtARm//hagWdbsPmyC1g==
X-Google-Smtp-Source: APXvYqzWBbPLVBPrbFmTJEk5UIt7x6cHDuEBIJzj+RPH298Lvex7X1nAJmKmLK8YBWA/7kyIcORyGRLOjXTDhT0qVT4=
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr31112655pls.179.1559595616814;
 Mon, 03 Jun 2019 14:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190603204953.44235-1-natechancellor@gmail.com>
In-Reply-To: <20190603204953.44235-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 3 Jun 2019 14:00:05 -0700
Message-ID: <CAKwvOdkSJzTrJMvRzOvLrSh7Bwqf+a3_X8Z=v8_mbpNC46A9yw@mail.gmail.com>
Subject: Re: [PATCH] net: mscc: ocelot: Fix some struct initializations
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 1:51 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> Fixes: b596229448dd ("net: mscc: ocelot: Add support for tcam")
> Link: https://github.com/ClangBuiltLinux/linux/issues/505
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

LGTM thanks Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
