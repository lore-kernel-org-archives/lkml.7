Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC7CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39252083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555038827;
	bh=li2vdXSxTbZHlWLCRNC+xG7xIIhnZYFJcAnB8lZF6xQ=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=eSx6Vc0jfVlNIQTt+jzNPXj/j7aK51cskuYf4xlQCpx10kOYChvZfAnrDSqfmeSUd
	 VRuKZHD+wh42h/UGJ0hSg5yt7fUaifnR9eb2RJ2RAPwJ1XjGjqj5OHmW2NgEfDKVMN
	 Lhr/bVbXKVZaRCbhuvb9E3RvNOcx6ERFwupByW34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDLDNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:13:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34223 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLDNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:13:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so7177703otf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 20:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=li2vdXSxTbZHlWLCRNC+xG7xIIhnZYFJcAnB8lZF6xQ=;
        b=JNGSe+YeYUW8n6OVyE1roSOg4DxD4g4ghvuCvpaYjeGwXWfZdM3Z3U4JtJ79lEKj0W
         a4O9Mu2/I2krrXLlOIM1Yf6DJSyVaQDP6/1388JCA3kiLBzjQ2/d0W2H//+/Eut9eNi/
         DVasSnInfWUtAvf488+wOl8ZFeHe3HqqV500fCPNWXzrVy98XAtBqMCZSopPryj1Hui4
         yqKMqfIL35bxASX+s+xr4EGfq8+zy2n1Wkk6phs9Nq/pwYm1ogTXUqJmli1PHzoiI5do
         Kww+2AqcmNBV+V9utUSA88zbHQe9LxU9fWhtfpAtFI3mhoKCz7K95APqPg8XKm3W+SBV
         FJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=li2vdXSxTbZHlWLCRNC+xG7xIIhnZYFJcAnB8lZF6xQ=;
        b=PxPCKxQEpsLveLXoJkf70UyVcocMnAMx8MhhgMbxWggT+jn3tFArNAfPWGHqJnW22N
         Zb0dMcmRLSu0cRJC1xj+QPOviGlaIbOB2UoOZ1gFnDL07jFpqI7Q/ih9qjdLZi1FztlL
         ix+I8Gk2jUycMSKgRXXexi5GYGMpdt3z6KFQk7r+E1/46ALbM670d+VqP8fmlNYXnUIr
         UW2dCpI0EUwXoLdEhQnbjvv5XfQ6aqk0qTD0zgiKkw/SPUouaGoE9h1QWCt+lK0iBaPZ
         rIlRSUq63G1yoGafyBM1nOj0inNUmfNGo6cxqleIsSOmlSVL+c4oEwK09BZf7ODa3eHW
         gzfg==
X-Gm-Message-State: APjAAAVzxrzx3mfm2cV23Li8yg76dzwlqPsSCUQQGZ7743VAlHNVPO6+
        u+JmsXFoqhcoE7iAIwWIXaQ=
X-Google-Smtp-Source: APXvYqyYVQgikdkDDFOU4yd62nXoI8zKxWpJR+Lv0R+IzylrYgZQUx4Z/6QXdiHK6Ld6ZCboBRze+Q==
X-Received: by 2002:a9d:1c2:: with SMTP id e60mr36205042ote.122.1555038824047;
        Thu, 11 Apr 2019 20:13:44 -0700 (PDT)
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net. [75.58.59.55])
        by smtp.gmail.com with ESMTPSA id r3sm16559921otg.24.2019.04.11.20.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 20:13:43 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v4 0/5] init: Do not select DEBUG_KERNEL by default
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org
References: <20190412014355.25307-1-okaya@kernel.org>
 <20190412030237.GB1577@localhost>
Message-ID: <cb6b69d5-73dd-e11f-bb4c-f0ce4b9d14f0@kernel.org>
Date:   Thu, 11 Apr 2019 23:13:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412030237.GB1577@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2019 11:02 PM, Josh Triplett wrote:
> I noticed one minor typo in patch 1/5, with that fixed, for the whole
> series:

Can you point to the typo?
