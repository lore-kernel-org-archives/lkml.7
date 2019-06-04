Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A28EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC00B2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kSGpqLi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfFDTio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 15:38:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46020 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDTin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 15:38:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so10915983pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5awe/yDakGGO/BxwxBGm2kDwtqm01hxaeRIR5WSClTE=;
        b=kSGpqLi9hgVEttJY+zJphTmom5Q5BaBDXDBe5zqhVVAGx7/lugNzzuHC7qLjH6bnXr
         IUe2OT/8ZM/oxAdRpwwWcyUEv7AUKPVc3AYzfI/eItQVRaisMwh9h7SPmJZvCIYcZO8E
         k0KU0cJ86d1ViyKOEcuw5rfV9Iturz7XlAV/RSWm36Eo82G5fTfwPv19U8bu4Gqxr+CM
         BOCLx6BdgS+3LP7moHlYOItVLkSA+uR6lvepvP/wm0DjH8S9/gjwkn3dESclnow+ueU/
         4U/x1D5g4h53bvUfCc0X3Likoos40SvliquEQdlR35M4pDRvMfbhkhbCoZHuLe1G8KmI
         OGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5awe/yDakGGO/BxwxBGm2kDwtqm01hxaeRIR5WSClTE=;
        b=gOJOT8BPO0SngzOvm5JcW8U4rKlxihzVZgflhh2Kz4m2E3LavdFx6gESwnH9XVmxfs
         YjqpLDz8mo85hDKZhTcmbS1FZ0acH1nzWYSMm2kdiYKgcl5GuGpKNM61+FeR5DF6Nysk
         6QH1G/r7oO244dru5ZeadAT1qrBYCrVegF5GHZzFc8ZfckyNtSXvT69xmV3lRAq+rxVo
         nyltg6N6WWOUn4QAvoF1KCOEPMB0jqnC37v6soB2+I4j2xFo8VOFXiSnU4Jn37FOsSLz
         O34OxwAHfO0Kq95fAxRXlyWZ/xsaNIJut0PXX84JDoZpWNzBaejuAef5vA5tffmLfx9W
         NjcA==
X-Gm-Message-State: APjAAAUk5eZfSBq2hU/UlmemTmlsyVYOepp2sdR4fZsVdOvaPsHZ+sc7
        W2HmZG66agonu+UvPCYF8R3AUFFlbShsqw==
X-Google-Smtp-Source: APXvYqzdwHso23dJP5b3wNfTmRHfedIauNzwirK6VyEPimLWGvRmxSf7WGgEInbzWLKS1kSSfaNzKg==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr295216pgc.140.1559677123064;
        Tue, 04 Jun 2019 12:38:43 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c129sm21243833pfa.106.2019.06.04.12.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 12:38:41 -0700 (PDT)
Subject: Re: [PATCH v3] block: aoe: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Justin Sanders <justin@coraid.com>,
        linux-kernel@vger.kernel.org
Cc:     "Ed L. Cashin" <ed.cashin@acm.org>, linux-block@vger.kernel.org
References: <20190122152151.16139-5-gregkh@linuxfoundation.org>
 <20190603194754.GB21877@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <168b8cf5-15ed-a4c1-6393-4f8df336a68e@kernel.dk>
Date:   Tue, 4 Jun 2019 13:38:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603194754.GB21877@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/19 1:47 PM, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Applied, thanks.

-- 
Jens Axboe

