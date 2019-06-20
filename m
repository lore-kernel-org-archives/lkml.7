Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E429BC48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6342082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vYO8y7Jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfFTJ0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:26:45 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45113 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfFTJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:26:44 -0400
Received: by mail-yb1-f193.google.com with SMTP id v104so956001ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yhqOWcsVMRLUugSeb1eby5Cv08pN53Ic4ZUoxcG3TJo=;
        b=vYO8y7JkLy+Kw57JCh+SGP9xT4ECOc2Zr9Btu65hng9dKnuiBuZk6CsiLkCq4RBBiE
         Rt814xsd2FG38spTJAwavWlrASeDrh04YJy6BJV2PJ8gnMbEFt3i07KWpbSr4StC4UMx
         XczfK91OAASx0SUJsrdUKv4SdNXbPUbAscwoQb0bJuux7Dh4aROJ6g47hv1MQd1ZNkgG
         1JOi23/ECEeqQaKoBA+/eNJ3TqKAigbaQYavLEKdbP8Nn9w5dY5meIxOtFRztn7dx3xZ
         d2bTtAubK2N1SigHRkYOEgU1px3bBnd3xTKzPWbMlxtO2pk2g0d0XLAWT5IqLy74MM63
         9PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yhqOWcsVMRLUugSeb1eby5Cv08pN53Ic4ZUoxcG3TJo=;
        b=pJA0KHNzr9tVePqGOis/39QmXjY9prbHOCTSIQdSITEKPPZr+E+qrChsatprqzrr/v
         uWxUTRaPLPCtq6ZB7dDDvL4y6UwfCk0ej0D52ypUL/EyOkrd3PxPv/9lbFt7PbghPHPi
         QfQb5EV7l5uUJSr10aIeld2jgyi/NNJANNuKuBiu2I1lyoeusmVUiNn4gqGL8mTbgi2s
         orw+OVBCp492LBENO+K1zY6+VSsiZxtkCYmq1vpKv4PWYAtlTWGBJRJbBjLDDsGxI/H+
         zvVxx/proCk5T6eXKu04HkOOZUBJXhHUVPWMMcK68N1lHyo0rUpwqnoNJH0x4m3KmO4D
         mc0w==
X-Gm-Message-State: APjAAAVWKR0wFrLmfduP2d/UL/cTHHyy5j2UzB7mSqY3AYnYOGKMxL+8
        perwgQhVWmK3JUDoNVjYVKZ/MjEY90jgtiYd
X-Google-Smtp-Source: APXvYqySUz1cIJX6NDR8ngA1GjoraRplX/O24N5dzHr1ye9UYfXOj4X5kPzZsGimkTHVjqrgsBpHlQ==
X-Received: by 2002:a25:cc0a:: with SMTP id l10mr7239938ybf.433.1561022803695;
        Thu, 20 Jun 2019 02:26:43 -0700 (PDT)
Received: from ?IPv6:2600:380:5278:90d8:9c74:6b59:c9f5:5bd0? ([2600:380:5278:90d8:9c74:6b59:c9f5:5bd0])
        by smtp.gmail.com with ESMTPSA id l143sm5657391ywl.107.2019.06.20.02.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:26:42 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-core: Remove blk_end_request*() declarations
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8c174fbe05ef879f2443b01e3ffb340a7f524d40.1558626111.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23ecea9b-7833-5b77-11ae-7e989cc89385@kernel.dk>
Date:   Thu, 20 Jun 2019 03:26:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8c174fbe05ef879f2443b01e3ffb340a7f524d40.1558626111.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 9:43 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> Commit a1ce35fa49852db60fc6e268 ("block: remove dead elevator code")
> deleted blk_end_request() and friends, but some declaration are still
> left. Purge them.

Applied, thanks.

-- 
Jens Axboe

