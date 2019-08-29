Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E659DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8EA21670
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="Ie4C9ynj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfH2XVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:21:20 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:45346 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfH2XVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:21:19 -0400
Received: by mail-pf1-f169.google.com with SMTP id w26so3157369pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 16:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qylN9i4xaRuIu/7tRX9HS4iq7VIt3+GlRK/+MNDbrNg=;
        b=Ie4C9ynjICNmD8YI/lrwt+CuSoJ4jS2F45DzqTE5d/yp5txlNNfrkIfxw070/P0ESM
         djnJjJZFKTlq5Huyr7zYeGh1+u+qvmHRacfJgfkzgeTC9PpGF+wFoCDSiRg7oceXCUKO
         BxeV3BPhy82yYFWNMzh3As0D36lVKI4L/hNfHp46O05tHiXnh0IpR2JByJnElnVBkaAm
         gjvllZBT9LPT7hJOFIeq5P7Xs1MNPb7eebGQ4DW5FptSBQEPLHmfZh7NF5c5C48kieIr
         hAQtrRby4yOAAVvLGEzUGd4rTqS3megv7gd/kwEr4/TB6CUzokDCrfr5tdzvG3CTjTG1
         Inkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qylN9i4xaRuIu/7tRX9HS4iq7VIt3+GlRK/+MNDbrNg=;
        b=kWge8zpkwEcYI7B0gThCB19Ue64oayqkGRGaYcfAtFxjf+R3ZMudMOA2S/alNIjkCJ
         IvGZYbZbvC/yldlKciA1WZD7nv5ESAzh/VPvlv6Z7zjDXv5jGMuwrLynaJU+nkTQg4M+
         hg44oBmglpGov9rZb9Eb19sYq39V6XnHBX3uYVwL/w8qRp7jGNeBJ8cQiACPVym6xsBW
         Syp1Lm3ndOIK1fr9HisRJt7k+Iql0iqnBhFHkyESw0zGMrfSAP7Z00sxiZujcUkFNH7M
         W86TgRoPmka4PfUuXN+jaqOhp39fH7p6Ru5LZnYQ2Un3NPLkcKXgWgCisbbkUvrM3nF3
         +uYQ==
X-Gm-Message-State: APjAAAWqqi/2TSsqoHpp9HikJXt2FzWrGOZlVKA9fHoA/XewaakGwuD4
        IkVnh0Ch+nwtMIyQzx38qmQS/A==
X-Google-Smtp-Source: APXvYqwzUfSkqIcFKaXDQZeFwsZiRgKFyEpVVe9g6ARNrlQQDUlfVtgVtSD5Foj7gS5xRWRl8LPyKg==
X-Received: by 2002:aa7:96dc:: with SMTP id h28mr14608679pfq.86.1567120878639;
        Thu, 29 Aug 2019 16:21:18 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id x128sm4088989pfd.52.2019.08.29.16.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 16:21:18 -0700 (PDT)
Date:   Thu, 29 Aug 2019 16:21:15 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     David Dai <zdai@linux.vnet.ibm.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zdai@us.ibm.com
Subject: Re: [v1] iproute2: police: support 64bit rate and peakrate in tc
 utility
Message-ID: <20190829162115.2644488d@hermes.lan>
In-Reply-To: <1567032776-1118-1-git-send-email-zdai@linux.vnet.ibm.com>
References: <1567032776-1118-1-git-send-email-zdai@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 17:52:56 -0500
David Dai <zdai@linux.vnet.ibm.com> wrote:

> For high speed adapter like Mellanox CX-5 card, it can reach upto
> 100 Gbits per second bandwidth. Currently htb already supports 64bit rate
> in tc utility. However police action rate and peakrate are still limited
> to 32bit value (upto 32 Gbits per second). Taking advantage of the 2 new
> attributes TCA_POLICE_RATE64 and TCA_POLICE_PEAKRATE64 from kernel,
> tc can use them to break the 32bit limit, and still keep the backward 
> binary compatibility.
> 
> Tested-by: David Dai <zdai@linux.vnet.ibm.com>
> Signed-off-by: David Dai <zdai@linux.vnet.ibm.com>

This needs to go to iproute2-next not iproute2
