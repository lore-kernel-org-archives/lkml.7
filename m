Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B88DC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 03:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E0E20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 03:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDiyHGnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfDMDJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 23:09:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43164 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfDMDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 23:09:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so5988759pfd.10;
        Fri, 12 Apr 2019 20:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DFdelcsbDZnOoLCXquw1TPsIVEBVeGOXBP7F50+M7gY=;
        b=tDiyHGnKxP2xeh7wnf15wHLTb/s7fb0OGOB97fAviK1Xr3LrkKLuFSRGbKrU8mXpri
         t+cD7v4ScdsaHXynvJm5O5Uj3JmyKQw3qZfSlGIU2p2c09lXRWBz4bLqqyRn9Cv5ER6T
         K/nmUg4FLHGlpFAO7q8k8XQMFOVvhBnqS28c31pAsWgzIfqyiazn2zND5p3NYS7RVfTP
         Kxg+jgEiECO5W5QcuMoTSCXDJuh+5TfmEthOw/qSSbyPrxvXBpzdRti3zXGgULnpFthw
         mPnMMlTbG4BaiLZKu6YIcZml0T2cMCtMfZM723lVW1qJyNefE4TELy5ayJJYnoPJfra8
         ZMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DFdelcsbDZnOoLCXquw1TPsIVEBVeGOXBP7F50+M7gY=;
        b=Schat/T3Vg/5PuVLXbEQo9TaRzJei8l8r/W5RQhKUaj8w/Mtt2Moaj34+/57M64tu6
         ezkM69fbeWEoAVsctDy5UP0W1yYuHiaCeW2FOmFV7uxU1PfAy9lc86wwSxiiciVRjs84
         CyA+wB+s5hMCG5ITYwVXu8h3ZClTGcm2JnBanQugAQcJzxa36aKlQPDAsVlYZBG2Gy2i
         VDdiNY+W7gzZfWedAoUxS2nqM3oZYs2AZOg6dIwGoB8RbywS5LQ0WGpxm2cIvEMAMpOT
         gEj8SORGJY8vIzKp6sDZDA67Y0FLWW7oydk55nNm3/Or9alL1inntY7qxp8YXv/vA/Tf
         mutw==
X-Gm-Message-State: APjAAAVAVJXJZcRLYuwDVm1QuCJw8TAfFQoSG4hfiBYtGFfa9IkSAJsW
        noIhFtfgiCV21273vjQDr65iQpab
X-Google-Smtp-Source: APXvYqys27IV7eEME8zssn8b1sPRVx90pSTxxQ4us1eyyXmJinya5HOqYOULNI0gOho4ApmkZ+qXuA==
X-Received: by 2002:a62:1c54:: with SMTP id c81mr18715786pfc.122.1555124960165;
        Fri, 12 Apr 2019 20:09:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u6sm40106601pfm.10.2019.04.12.20.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 20:09:19 -0700 (PDT)
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net> <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net> <20190412100451.6fe49de7@lwn.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f900adea-d231-c00d-847c-33e66e79ea30@roeck-us.net>
Date:   Fri, 12 Apr 2019 20:09:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412100451.6fe49de7@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 9:04 AM, Jonathan Corbet wrote:
> On Thu, 11 Apr 2019 14:07:31 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> While nobody does such split, IMHO, the best would be to keep the
>>> information outside Documentation/admin-guide. But hey! You're
>>> the Doc maintainer. If you prefer to move, I'm perfectly fine
>>> with that.
>>>    
>>
>> Same here, but please don't move the files which are kernel facing only.
> 
> Well, let's step back and think about this.  Who is the audience for
> these documents?  That will tell us a lot about where they should really
> be.
> 
> What I would prefer to avoid is the status quo where *everything* is in
> the top-level directory, and where documents are organized for the
> convenience of their maintainers rather than of their readers.  But
> sometimes I feel like I'm alone in that desire...:)
> 

The big real-world question is: Is the series good enough for you to accept,
or do you expect some level of user/kernel separation ?

Guenter
