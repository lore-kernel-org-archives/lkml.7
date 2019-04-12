Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2989820869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555042019;
	bh=9X0GDS3Go7tuH6GVdO+zZ6FxNohzLPIWkcnjc3OPBAI=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=V7d+U1wcArW/wigUGBuMPwX3K3nG2nWTwvAgjF3ilxlZ4viDcOP0CYofT5GtAxmgd
	 kOFRLL2z4xCFGnI92qJSFnzXjyk2saDjLOxbafsZZ95VeNxi6p9o9vrTf9k+FhYDAh
	 Lx5LG1+Q5uPS6EbSQC8z/yPt4R0Fg2xVjUpOspzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDLEG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:06:58 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44601 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfDLEG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:06:57 -0400
Received: by mail-yb1-f196.google.com with SMTP id u187so3095011ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 21:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LC/zOD4PykpRTyFyfsieKm3TtHSlD66UJnpDFJ65njo=;
        b=n+euqA9MJDQTJZpJkzYeEUbyM5o4ltdGXO//Ep+fpgeLDWiRkA0cIiuyg5TZ5a0EYR
         FQFn6Be7X5Qhw7ePAmVJm4GFfsqFEfla7YHdAggHcE25H/qsunJQG6D/EGlxTejAlySf
         miR+pCsFWwGWQUyoHz+CEkQ/NLVYK4abdQrgIuEqLFEqypJ5ALCrdKTkLFmTxr0L5msq
         kP/xE7AbP0nOiWRM4gJ4hAtVNy5zX3KCmLcMf3dYvQ7UkwUQCJb0X5qbRUnK166SPYPE
         IKksuPa0U2uU0tqmoQEFtdObLgrUYmsgnl48DgT905kmUkVVyKpL402r4winOXutdlHG
         08Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LC/zOD4PykpRTyFyfsieKm3TtHSlD66UJnpDFJ65njo=;
        b=X2YOtiUsBMPmgjWv/dKVRt5oG4ogJYTYhED0u7WG3DQRQBDuoqn7MSLzEra9TTvLow
         dkAk0ZVhEShdTuS9dr6pMfVNHMMw8IjyxX3MIOshXd+m3Dqne714j3S4OSpp+IgrgW2j
         +9RSlXsnPLYMIupaQKf2JYLossB+YpFPWl873ynODHJFJ77y1rHPsm1SOQ5uwByAAZou
         9JMI8enl+r64T6UW15ksfotbhlFecJRQtO+nsIr8MCx+E/r0O0wZIjYeOyhcGmyDKfxl
         kXZLUO+GLvgsfNKNIthscHBXfBE0BlTaL9nmJMlimjxptVhu4LLOgveTLWJA51TuVVWz
         u8Wg==
X-Gm-Message-State: APjAAAVcfrhOxnWfxrQPxj4sWJ16xOuxBxbCFqJKkdziOsPCmS/hWAqS
        aQKxyKPxpWXKn6b4sDmKk3M=
X-Google-Smtp-Source: APXvYqwsOysr/3VYupUoD939sV9KAdT+nL+bsT3L8d6ZKPvR1AKPokEspM+mvRX2qK6hd27hkNE6ZQ==
X-Received: by 2002:a25:3187:: with SMTP id x129mr45101730ybx.315.1555042016774;
        Thu, 11 Apr 2019 21:06:56 -0700 (PDT)
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net. [75.58.59.55])
        by smtp.gmail.com with ESMTPSA id i206sm15185329ywi.99.2019.04.11.21.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 21:06:56 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v4 0/5] init: Do not select DEBUG_KERNEL by default
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org
References: <20190412014355.25307-1-okaya@kernel.org>
 <20190412030237.GB1577@localhost>
 <cb6b69d5-73dd-e11f-bb4c-f0ce4b9d14f0@kernel.org>
 <20190412040546.GC1577@localhost>
Message-ID: <e8c9a53b-851d-ac36-9eea-ffd0e42a6b9f@kernel.org>
Date:   Fri, 12 Apr 2019 00:06:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412040546.GC1577@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/2019 12:05 AM, Josh Triplett wrote:
>> Can you point to the typo?
> I did, in my response to the patch itself:
> s/Miscellaneous/miscellaneous/ in the new option's description, since it
> isn't at the start of a sentence.
> 

Thanks, your emails arrived out of order. I got them now.
