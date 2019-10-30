Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189F7CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB91E20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="APStmm2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfJ3PAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:00:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34291 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3PAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:00:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id 139so3068070ljf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t++HF3tscy3V/wh/kTRJzh1qufAuUyRQnA+rQJgsrZM=;
        b=APStmm2+15s8QErOHJBekI63+aPACEuwIcUFXIWFGEuD/Njlb8KP75fiK7wNwkCEXz
         btNIjqZMF77IRMVrUfhaHPLc8imZyizKk+fu6rUZxOeSQNA4QYrndmfJQM1cFMmck3WP
         aG9Y6Lx1Cna4+EQOaaCE8ZcrbO1PcaqOUT6TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t++HF3tscy3V/wh/kTRJzh1qufAuUyRQnA+rQJgsrZM=;
        b=dTG3UK5VX92dILBkyjbBb3OhS7aButcQEACeUZ+cYBgl9QC0sYCm/8i45Wlt5smwIb
         8vVhM0wlLAu3rr5Yx3JI6MVTzOKkSpuW9nYHryvFQAn6vZRvM7DAcrMClP2LUDadNLRM
         v75V4C32OB88FhfQ8x2rxCRBSnNS2vt95Klwrev8y1G6LTck9dk+ithYbZjSaiO1RNWh
         4ubPyN6xGNkphmYrNTIjj2ihQ5DR8vGby+y7C1dXWk8PLB9VWb3g/vBmnfFakeu59J3p
         WIOjwreFnU9CtBdxN6/wR8l7toaljhcYTzBU+fP7qDWQsrzw5AxwIPzutqPhM0ZsPFKi
         p63Q==
X-Gm-Message-State: APjAAAVmR8CZXqpOLWqS/brS8Va4rpA3aI+UCvSzCSxMCxMaAzRSbOa5
        kNUGsQewbGBZ9tGsm4NcHoY4PLRzoTTKzYYh
X-Google-Smtp-Source: APXvYqyagveqp2aU97Xw+jkalxGljwe4I7i2l/PaT3U40q6N5OUMBtG9Xd3p5/mH1O1yIu7T0GxypA==
X-Received: by 2002:a2e:99cf:: with SMTP id l15mr114618ljj.109.1572447601552;
        Wed, 30 Oct 2019 08:00:01 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r5sm112435lfc.85.2019.10.30.07.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 08:00:00 -0700 (PDT)
Subject: Re: [PATCH] lib: string: reduce unnecessary loop in strncpy
To:     Liu Xiang <liuxiang_1999@126.com>, linux-kernel@vger.kernel.org
References: <1572444859-3687-1-git-send-email-liuxiang_1999@126.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c6452618-0161-eefc-0730-b10eac823228@rasmusvillemoes.dk>
Date:   Wed, 30 Oct 2019 15:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572444859-3687-1-git-send-email-liuxiang_1999@126.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2019 15.14, Liu Xiang wrote:
> Now in strncpy, even src[0] is 0, loop will execute count times until
> count is 0. It is better to exit the loop immediately when *src is 0.

Please read "man strncpy".

There's a reason the loop is written in that somewhat convoluted way:
The behavior of strncpy is mandated by the C standard, and if the src
string is shorter than the destination buffer, the rest must be
0-filled. So if we hit a nul byte before running out of count, we keep
copying that nul byte to the rest of the destination.

Rasmus
