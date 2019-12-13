Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC43C3E8AE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8375E246B3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Eu6jZTZ2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Eu6jZTZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfLMR0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:26:01 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41908 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbfLMR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 12:26:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ABE2D8EE19A;
        Fri, 13 Dec 2019 09:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576257959;
        bh=cmlDkaHhdLMtJTUfRnK2Kihnle7r/X/R7Z8wR6Tc2jw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Eu6jZTZ2aoGWQ+h6efs/N4mhgMH0CZmN/Su3qNcDt5iEemXKYMkHWrQ7RC5+644EN
         b85w2OICaez3dWdY9QNo8hj3c2+8AhIvS3jI7muPhoTYUkX58HklAStL6UgD2/198+
         LRWTSeO3uRnu+1SVjplouMMOb4NqOgv0c5dUkSso=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R3YuPfNVo9JD; Fri, 13 Dec 2019 09:25:59 -0800 (PST)
Received: from [9.232.197.95] (unknown [129.33.253.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 40D7B8EE0E0;
        Fri, 13 Dec 2019 09:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576257959;
        bh=cmlDkaHhdLMtJTUfRnK2Kihnle7r/X/R7Z8wR6Tc2jw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Eu6jZTZ2aoGWQ+h6efs/N4mhgMH0CZmN/Su3qNcDt5iEemXKYMkHWrQ7RC5+644EN
         b85w2OICaez3dWdY9QNo8hj3c2+8AhIvS3jI7muPhoTYUkX58HklAStL6UgD2/198+
         LRWTSeO3uRnu+1SVjplouMMOb4NqOgv0c5dUkSso=
Message-ID: <1576257955.8504.20.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued
 keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Fri, 13 Dec 2019 12:25:55 -0500
In-Reply-To: <20191213171827.28657-3-nramas@linux.microsoft.com>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-12-13 at 09:18 -0800, Lakshmi Ramasubramanian wrote:
[...]
> @@ -165,6 +167,12 @@ void ima_post_key_create_or_update(struct key
> *keyring, struct key *key,
>  	if (!payload || (payload_len == 0))
>  		return;
>  
> +	if (!ima_process_keys)
> +		queued = ima_queue_key(keyring, payload,
> payload_len);
> +
> +	if (queued)
> +		return;
> +
>  	/*
>  	 * keyring->description points to the name of the keyring
>  	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
> diff --git a/security/integrity/ima/ima_policy.c
> b/security/integrity/ima/ima_policy.c
> index a4dde9d575b2..04b9c6c555de 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -807,6 +807,9 @@ void ima_update_policy(void)
>  		kfree(arch_policy_entry);
>  	}
>  	ima_update_policy_flag();
> +
> +	/* Custom IMA policy has been loaded */
> +	ima_process_queued_keys();
>  }

There's no locking around the ima_process_keys flag.  If you get two
policy updates in quick succession can't this flag change as you're
processing the second update meaning you lose it because the flag was
false when you decided to build it for the queue but becomes true
before you check above whether you need to queue it?

Note you don't need locking to fix this, you just need to ensure that
you use the same copy of the flag value for both tests.

James

