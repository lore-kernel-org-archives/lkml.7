Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC0EC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E6220850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv92+G43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDLNrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:47:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41914 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfDLNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:47:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so5178861pfd.8;
        Fri, 12 Apr 2019 06:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IwA2lo89h0lQucOsO0pJ89LrkKOX/HbdRemyEpHpiw8=;
        b=cv92+G43ISNf9A3p5ARN0YtuYVR5EpyI8zD8Bqc5u4vwbuGQv6MMNRv5oc347eSWE1
         GWwY9xkTpOHjVdlbSDQMxOzr7K8tQq40K2Gr7PApzoevPjmWvnAo/10wfdMB+DmaTvtA
         K9rRKhlccYn2nKZmnvTSHrXjHg0A4hZEoDr2b1wTCZa3heXtUl8MdpNCQJ17oXvCFH41
         oIqOmag4e11SyrWHeO+uAU6/CI/67s0nps2fi6ZFx54mATEzGu1LVqZLbIQgCq4f6Y/e
         DDd+5+7EInLh70IvmqxihAy8faJQVgkiSnnWOC3ji0aiZvbaFzBBKIxebi8SI4uJxtFG
         1JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IwA2lo89h0lQucOsO0pJ89LrkKOX/HbdRemyEpHpiw8=;
        b=FImHUs3RCsnhGbDyfefInq07zumqYH9MSES2PdKX2RfDJBCzlPhtBbMPd1nuJi7Dd5
         hhPBoMs497XW33zvDD+j3GrafU9Arg4iLqzJM25crx6Nyh/p7sLfPSSLydfC+rDadblu
         rDc8sSfaGsOC8wJhod2OJg27wOftNa/1BeJs+BHIHcBM+tsJmidr7N4iaV9o6XW8OoPn
         IZHgDqPBGLYjq7VYgen6r2UEmEFYmMqFGdvi7WJvsDPowFDCbwnyAqWgb0YihvFjZyOd
         zaMCZctBZnkGPZW0BPodL+ATp33ZzbAjEA8/b22iwKbxainnO5OCD8nz5Cfyo9L+2Zr+
         A/cQ==
X-Gm-Message-State: APjAAAUDYYFpDC0kNOO56f5DFJ3VZhkd9HIeO917/TF8rgfV0KC0rDA8
        qIBQvpScLKce3r83uMyG/+oaJbgQ
X-Google-Smtp-Source: APXvYqyjB9tIenwUr+cMIuTuIN5oY+ijrkfOLoptm1Z1GDY3jdchDESLW1XbpVg8lAz0sB+Arcuagw==
X-Received: by 2002:a63:2f44:: with SMTP id v65mr52929139pgv.141.1555076843457;
        Fri, 12 Apr 2019 06:47:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p128sm100361757pfp.30.2019.04.12.06.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:47:22 -0700 (PDT)
Subject: Re: [PATCH V5 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
 <1554989411-23666-4-git-send-email-stefan.wahren@i2se.com>
 <24771fbe-0c45-78b0-e96b-6ed31ccdcb7f@metux.net>
 <518757ac-b0d7-298c-c896-4bd7e3b2ac5b@i2se.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b0930582-7528-bda9-214b-c6df8619c1a4@roeck-us.net>
Date:   Fri, 12 Apr 2019 06:47:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <518757ac-b0d7-298c-c896-4bd7e3b2ac5b@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 6:35 AM, Stefan Wahren wrote:
> Hi Enrico,
> 
> On 12.04.19 15:15, Enrico Weigelt, metux IT consult wrote:
>> On 11.04.19 15:30, Stefan Wahren wrote:
>>> This adds RPM support to the pwm-fan driver in order to use with
>>> fancontrol/pwmconfig. This feature is intended for fans with a tachometer
>>> output signal, which generate a defined number of pulses per revolution.
>> Wouldn't it be better to have a CONFIG_* flag for keeping the kernel
>> image size smaller when this feature isn't needed ?
> 
> i compared the kernel module size in linux-next for ARM without and with
> this patch:
> without patch: 12088 bytes
> with patch: 14292 bytes
> 
> I don't think it is worth the trouble.
> 

Agreed. This would end up being a mess, with lots of configuration options
in various drivers. Please don't start it.

Guenter
