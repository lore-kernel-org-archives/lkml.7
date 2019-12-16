Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3E5C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B8C20665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9q0H6hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLPJpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:45:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51566 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726937AbfLPJpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576489499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnDdBf82KhVXnWr+anktiJJjISUtDVrUWwe+tyMdfr0=;
        b=E9q0H6hyzIBad2lTqen6qLRZBqu33YTq0CrqZZ/PJXAh1uewhrpUN+sNzN2oaw9xTKtmQe
        SKtruJxM6JqIYS92jhu9Ucl22JkWd1gEKGbjlCDbFgtEfBwK/FSBgpgU0LMjSzgzET98q1
        BdThgwqSmro7w2XCf2FcYrehiQQNVE8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-HiMkFhcfOQK-d35e0RvnsA-1; Mon, 16 Dec 2019 04:44:58 -0500
X-MC-Unique: HiMkFhcfOQK-d35e0RvnsA-1
Received: by mail-wr1-f69.google.com with SMTP id h30so3471009wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 01:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cnDdBf82KhVXnWr+anktiJJjISUtDVrUWwe+tyMdfr0=;
        b=Bp6mfmIHUgqiBhBRgx31/bsclf/dPrCQznR/wn7L9EptE6hvVM7ineZBHfEtNgm0jZ
         iy2Ne3C3KNbO6qy7LlbFKLP6Ls2Fyc57mWPLn+l2MwwMP8RXk6Obq7SWYND0OhHLZc0Z
         YtSRJTBky6gpWZGnJeZAaYDwWjJiSv4KwOQih2UQt9t9HqnqMvfEYbiLYJZeNF1aYy5i
         l/XadOT/h0+s/7X2hbgIsmAFyCs899Mazjek4sg9O8mjrXo8gUnFoZVUje5/EqnfF3yx
         TFd5qdSBVh8wmVFG+2W69HrpP1M/MdqYyP4MTugK6kUwMVlyF0qxb79MadWXr2DfbI3E
         xsDA==
X-Gm-Message-State: APjAAAUIWea9xEu6++pDxLBRHQpUP8+g1wAj4jm0FJhu//YG9mPnbNh5
        U6y7iaUMsnvjwjN/MNNV6MDwKPP7CKXzUefHMpQHPai1x3tVeoG1hO7hVi1Kwp5PrQ5yuup44In
        BjZAB8p7sFspIjzjjsZS5Msul
X-Received: by 2002:adf:f411:: with SMTP id g17mr28460639wro.89.1576489497497;
        Mon, 16 Dec 2019 01:44:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEyH6eiYWhPGokZxLoLnl2FBBKcXENk0ZwrWubb27++SVbpEDDa7w6koqgCE+ASXk2WC7KVg==
X-Received: by 2002:adf:f411:: with SMTP id g17mr28460620wro.89.1576489497258;
        Mon, 16 Dec 2019 01:44:57 -0800 (PST)
Received: from [192.168.1.14] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id b17sm20890045wrp.49.2019.12.16.01.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 01:44:56 -0800 (PST)
Subject: Re: [PATCH v2] efi: Only print errors about failing to get certs if
 EFI vars are found
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20191119115043.21585-1-javierm@redhat.com>
 <bb68bacf-4982-0d86-d2cb-7799e47200f5@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <4c90fae4-422e-c805-e2f3-d3b921cc614d@redhat.com>
Date:   Mon, 16 Dec 2019 10:44:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bb68bacf-4982-0d86-d2cb-7799e47200f5@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 4:40 PM, Hans de Goede wrote:
> Hi,
> 
> On 19-11-2019 12:50, Javier Martinez Canillas wrote:
>> If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the certs
>> from the db, dbx and MokListRT EFI variables into the appropriate keyrings.
>>
>> But it just assumes that the variables will be present and prints an error
>> if the certs can't be loaded, even when is possible that the variables may
>> not exist. For example the MokListRT variable will only be present if shim
>> is used.
>>
>> So only print an error message about failing to get the certs list from an
>> EFI variable if this is found. Otherwise these printed errors just pollute
>> the kernel ring buffer with confusing messages like the following:
>>
>> [    5.427251] Couldn't get size: 0x800000000000000e
>> [    5.427261] MODSIGN: Couldn't get UEFI db list
>> [    5.428012] Couldn't get size: 0x800000000000000e
>> [    5.428023] Couldn't get UEFI MokListRT
>>
>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>
>> ---
>> Hans,
>>
>> I'll really appreciate if you can test this patch. I just built tested it
>> because I don't have access to a machine to reproduce the issue right now.
> 
> Ok, I've given this a test-run just now, works as advertised for me:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>
>

Thanks a lot for testing Hans.

James and Mimi,

Anything else that's needed for this patch to be picked?
 
> Regards,
> 
> Hans
> 
Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

