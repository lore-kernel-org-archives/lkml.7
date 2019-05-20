Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C5C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CA72171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfETXP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:15:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37908 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfETXP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:15:29 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id AB7B620B7192;
        Mon, 20 May 2019 16:15:28 -0700 (PDT)
From:   Lakshmi <nramas@linux.microsoft.com>
Subject: Re: [PATCH 0/2] public key: IMA signer logging: Log public key of IMA
 Signature signer in IMA log
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        jorhand@linux.microsoft.com
References: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
 <750fdb9f-fc9b-24bf-42c3-32156ecdc16f@linux.ibm.com>
 <9c944ba6-f520-96e1-3631-1e21bbc4c327@linux.microsoft.com>
 <0b5ae493-6564-40e9-343b-e6781c229a25@linux.ibm.com>
Message-ID: <54663a75-a601-ae6c-8068-bc2c3923a948@linux.microsoft.com>
Date:   Mon, 20 May 2019 16:15:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0b5ae493-6564-40e9-343b-e6781c229a25@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/19 7:41 AM, Ken Goldman wrote:

Hi Ken,

Apologize for the delay in responding.

> Since a platform typically uses only a few signing keys, 4 bytes makes 
> the chance of a collision quite small.  The collision would have to be 
> within the same log, not global.
> 
> In that worst case, the verifier would have to try two keys.  It's a
> slight performance penalty, but does anything break?

Problem Statement:
- If the attestation service has to re-validate the signature reported 
in the IMA log, the service has to maintain the hash\signature of all 
the binaries deployed on all the client nodes. This approach will not 
scale for large cloud deployments.
- Possibility of collision of "Key Ids" is non-zero
- In the service if the "Key Id" alone is used to verify using a map of
"Key Id" to "Signing Key(s)", the service cannot determine if the 
trusted signing key was indeed used by the client for signature 
validation (Due to "Key Id" collision issue or malicious signature).

Proposed Solution:
- The service receives known\trusted signing key(s) from a trusted 
source (that is different from the client machines)
- The clients measure the keys in key rings such as IMA, Platform, 
BuiltIn Trusted, etc. as early as possible in the boot sequence.
- Leave all IMA measurements the same - i.e., we don't log public keys 
in the IMA log for each file, but just use what is currently available 
in IMA.

Impact:
- The service can verify that the keyrings have only known\trusted keys.
- The service can cross check the "key id" with the key rings measured.
- The look up of keys using the key id would be simpler and faster on 
the service side.
- It can also handle collision of Key Ids.

Note that the following is a key assumption:

- Only keys signed by a key in the "BuiltIn Trusted Keyring" can be 
added to IMA\Platform keyrings.


Thanks,
  -lakshmi
