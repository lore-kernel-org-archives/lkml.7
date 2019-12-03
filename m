Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F50EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B189820656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="de947gFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfLCXg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:36:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43348 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfLCXg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:36:59 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8BAC120B7185;
        Tue,  3 Dec 2019 15:36:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8BAC120B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575416218;
        bh=lumjR+WsAH17zIElti4at56HiP3oZKr0jeW3mqpgrHY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=de947gFnmNyOixr7N1TMZYsinoGV2xsUKN/WwfHNuRjXgU61OunOF3SifgKSmF89G
         bRi33LhmfBFfM/IFU2Yu66gQvpR3cgchy6aY4zm9ohJ6QAoEEtnJ4fz2nu5HSPCeTw
         tz7djkOq501rwSmZC9Tc6rKg2AJjuDbXf14n6PTs=
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
 <20191127015654.3744-6-nramas@linux.microsoft.com>
 <1575375945.5241.16.camel@linux.ibm.com>
 <2d20ce36-e24e-e238-4a82-286db9eeab97@linux.microsoft.com>
 <1575403616.5241.76.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <89bb3226-3a2e-c7fa-fff9-3a422739481c@linux.microsoft.com>
Date:   Tue, 3 Dec 2019 15:37:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575403616.5241.76.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/2019 12:06 PM, Mimi Zohar wrote:

> Suppose both root and uid 1000 define a keyring named "foo".  The
> current "keyrings=foo" will measure all keys added to either keyring
> named "foo".  There needs to be a way to limit measuring keys to a
> particular keyring named "foo".
> 
> Mimi

Thanks for clarifying.

Suppose two different non-root users create keyring with the same name 
"foo" and, say, both are measured, how would we know which keyring 
measurement belongs to which user?

Wouldn't it be sufficient to include only keyrings created by "root" 
(UID value 0) in the key measurement? This will include all the builtin 
trusted keyrings (such as .builtin_trusted_keys, 
.secondary_trusted_keys, .ima, .evm, etc.).

What would be the use case for including keyrings created by non-root 
users in key measurement?

Also, since the UID for non-root users can be any integer value (greater 
than 0), can an an administrator craft a generic IMA policy that would 
be applicable to all clients in an enterprise?

thanks,
  -lakshmi


