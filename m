Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB59CC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D3A215F1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OCxCKTdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfK0WF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:05:58 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59974 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfK0WF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:05:58 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1307D20B7185;
        Wed, 27 Nov 2019 14:05:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1307D20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574892357;
        bh=hG7ELv5aoHY2Qr84UCJGjmO7ITc/C6N/N/uFC2cKEps=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OCxCKTdWd7awntGqJ/+sm2/Tr90MgIXgXkgkcWf9/pIdQ2LZXJIb7XBPOOliBxbXT
         uwFMGMnQeBNHefQQnjMlfY1hRPdpxqtrdr0hauXViFvagJThLxYmrfkT/Ls91T+0n6
         r4pd1QDtFuIg2TVjIy1NO+kr81uJmxHBcf4BTe34=
Subject: Re: [PATCH v9 6/6] IMA: Read keyrings= option from the IMA policy
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
 <20191127015654.3744-7-nramas@linux.microsoft.com>
 <1574883174.4793.318.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <3fb64c8a-59d3-3390-07c6-283099f55f86@linux.microsoft.com>
Date:   Wed, 27 Nov 2019 14:05:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1574883174.4793.318.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/19 11:32 AM, Mimi Zohar wrote:

> 
> The example is really too colloquial/verbose.  Please truncate it,
> leaving just a sample "key" policy rule, with directions for verifying
> the template data against the digest included in the measurement list.

I'll truncate the example and keep it to the point.

>> The following command verifies if the SHA256 hash generated from
>> the payload in the IMA log entry (listed above) for the .ima key
>> matches the SHA256 hash in the IMA log entry. The output of this
>> command should match the SHA256 hash given in the IMA log entry
>> (In this case, it should be
>> 27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b)
> 
> Previously you didn't use the hash value, but ".ima" to locate the
> "key" measurement in the measurement list.  In each of the commands
> above, it might be clearer.

If the IMA measurement list has only one IMA key then locating it with 
".ima" would work - hash won't be needed for locating the entry.

But for describing key verification we can have just one IMA key. I'll 
change the description to locate the entry using ".ima".

>> # cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
>> | grep
>> 27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b |
> 
>> cut -d' ' -f 6 | xxd -r -p |tee ima-cert.der | sha256sum | cut -d' '
>> -f 1
>>
>> The above command also creates a binary file namely ima-cert.der
>> using the payload in the IMA log entry. This file should be a valid
>> x509 certificate which can be verified using openssl as given below:
>>
>> root@nramas:/home/nramas
> 
> ditto
> 
> 
>> # openssl x509 -in ima-cert.der -inform DER -text
>>
>> The above command should display the contents of the file ima-cert.der
>> as an x509 certificate.
> 
> Either the comments should be above or below the commands, not both.

I'll update the comment.

> 
>>
>> The IMA policy used here allows measurement of keys added to
>> ".ima" and ".evm" keyrings only. Add a key to any other keyring and
>> verify that the key is not measured.
> 
> This comment would be included, if desired, when defining the policy
> rule, not here.

Will remove the above from this patch description.

thanks,
  -lakshmi


