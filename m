Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51778C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210BC20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfcN1c1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfEWOcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:32:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33330 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfEWOcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:32:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id z5so614947qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=26O4OAT3StjGcdvXWdoax0aRus0DVxp2E0u/qprceKo=;
        b=zfcN1c1eomMu4+oxnKPYdhDF2+VuS/B2E91XN3OlCwQw7KkklrujUQt8Kn5EKAXrGY
         ky/1UB308P/7q0WsnVGs5zkXTd0UslTzabH6KAPdXvHo4ywiM4EJ2agZAyCfJm3t7kGh
         aJfKlvedmBR9f+Odt+gP5zlLz+6cPU0onGlKfVGSiOf1C4L4lRQJ4lTTjH4aGIf0hIU1
         eDpi16auna3NIpAhQOqkSI/vfO4QvFDbGR/p5yxpVQz0ftc712fBu5i+MhhNqFAY4hMQ
         KRW9jPEmbatolCDcubTgZulhcUm7MK+6TxOmmNTr/UujaPPAqinAbJOii1JTZMxPzTRu
         qGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=26O4OAT3StjGcdvXWdoax0aRus0DVxp2E0u/qprceKo=;
        b=tdNyYETT7Kvfiv4u5q2SFwp1FTLjbib19c24puwePwLdQKkdWPqnz0q0R4p8OoF43I
         vBG1GsYkS3jPk8tFuPg3Tk6ZifGrp1hX9d3wrB+kNYDdTuhHWQsUHnU/k6L4Ah43u3Ul
         rq+q7aN5U2S3KNxOjugSg9WTOgZAnLtG6+vqOegNFyy2f2FZw9nBlQ9ZKCygR96GgRfR
         WgdO/i5Co9CwN8C9gig+ODXsP5lBziX1W2R08xCR3AjfPevVZPrNDCwNoa/V9amDS6Kn
         Pb6h6f5mj699IMeBlvd3HTpW0Yht7C71hD43A8358rluyAQ/07Lor1IgZ+gM6HvBFpZG
         y6TQ==
X-Gm-Message-State: APjAAAXlHn8mpvxLCv1d+8rKPVca1QXBtSnJXU5G0JR8ey1i6vYMx910
        EOavu8SAEmDO4Z7sTQJ45Aig0A==
X-Google-Smtp-Source: APXvYqwhHNKz/pi41E5cnHTYcYzQ3e6W/Vv0HpqStGGaYWCsQz5zn9J2dosBcXxlTD20r8VmIj5f4A==
X-Received: by 2002:a0c:b50b:: with SMTP id d11mr27491149qve.98.1558621960357;
        Thu, 23 May 2019 07:32:40 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li483-211.members.linode.com. [50.116.44.211])
        by smtp.gmail.com with ESMTPSA id w2sm10446227qto.19.2019.05.23.07.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 07:32:39 -0700 (PDT)
Date:   Thu, 23 May 2019 22:32:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
Message-ID: <20190523143227.GC31751@leoy-ThinkPad-X240s>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, May 22, 2019 at 11:34:33AM +0100, Suzuki K Poulose wrote:

[...]

> Changes since v2:
>  - Drop the patches exposing device links via sysfs, to be posted as separate
>    series.

Thanks for sharing the git tree linkage in another email.  Just want
to confirm, since patch set v3 you have dropped the patch "coresight:
Expose device connections via sysfs" [1], will you send out this patch
after ACPI binding support patches has been merged?

When you send out the new patch for exposing device connection, please
loop me so that I can base on it for perf testing related works.

Thanks,
Leo Yan

[1] https://lkml.org/lkml/2019/4/15/658
