Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE09C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A75020821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoSGpP6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfDPQbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:31:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40106 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfDPQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:31:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so10665472pfc.7;
        Tue, 16 Apr 2019 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9w8GQShd9fh7QgNopJl5hpS0GF6JMHBJ6UPr+Hp7oTs=;
        b=OoSGpP6LAq7WKczfB/1tMO2UQIAz3xhZ9lJDh3ebbQ3GgvNkz72bzjnwcVLOcAb3CG
         OXXKKpu0kzeSnfIxNFyduT0CUinFHl3JtkxWlB0X9fpVl5i7AjGerNiwH3uC/gl6sWY+
         zVoOJadL7Ekxk93kpaDTlu6irUgbOjAICVJhncy2mO9xBd+h1JQmo9ybmdb6+/azX/OB
         wF6suMAVtKXAO84/riaFhIsKQ+dDy9TD83FFdYGlgKmcmGlmE7h2x75ydSXanxjWtEEW
         ZServIVndqo72qHlTo+j/eVBGwocgEMX3oJcfnVvUX41T9d4jer8C9znYfRlqTD0vU5k
         Fe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9w8GQShd9fh7QgNopJl5hpS0GF6JMHBJ6UPr+Hp7oTs=;
        b=oGwvfLNbKDclTRX9IFVdyZt0iVpPe1zLLDW2afeeDHAV/JN/g/VNguT2VbVdL3eoKH
         EpDV4V8099edEkS2jZx1njvr02GTxyoIVW7yJbZswPsg2X8kOM36vxAQADAUEz6J67hD
         PsIPSsZHmfJ0TswsZwFMu/HLQHRLZUEImpVncyEoadXBQIMFQoPwBlObTXwn/hwmH1jg
         f9/E7fEIDYxLPVJ51UqGj0/3UlqdfeF2QkosGQ74MTRN4g0MpVPdK4oZ3tMmjqwGqfDG
         T14kTcyPuUoqW7ry4AFiKq8BkjqB2ucl006/+d51sOsv0tZ8Mzw+mgZWE/7o+0uJN4BJ
         Su1Q==
X-Gm-Message-State: APjAAAXyBWEEFbTfX4MP6GZFJfXKmJU+CXBb+13W1S11rOuHTBZho3QX
        TQ/jPV7NjqQFWrxTV2E+vik=
X-Google-Smtp-Source: APXvYqz08zWJiELz3mbW/MWF/3QS1PEgxdF+z6hJxLh2ngFivPl/KtW22ou9AlekVA+q4LnsGVs9XA==
X-Received: by 2002:a65:62c9:: with SMTP id m9mr72065475pgv.309.1555432292183;
        Tue, 16 Apr 2019 09:31:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c17sm77265917pfd.76.2019.04.16.09.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:31:31 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:31:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/117] 5.0.8-stable review
Message-ID: <20190416163130.GD22656@roeck-us.net>
References: <20190415183744.887851196@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:59:30PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.8 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr 17 18:36:42 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 349 pass: 349 fail: 0

Guenter
