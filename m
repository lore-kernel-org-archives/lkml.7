Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3677C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74309206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kMnTf5Tw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wiUc3vsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgAGW0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:26:38 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52976 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbgAGW0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:26:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 55B598EE105;
        Tue,  7 Jan 2020 14:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578435996;
        bh=IMwRDmGBJbMcQP14oVqjfwTGrqu/1b1ETWng9igb/ss=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kMnTf5TwrXPjxbtdCFNyapoa6YitHx5vhUmyTv+X5IdsXs1qYkeNq+veco4thzI0l
         dXCb0wPTHK5OrH3b7/h7QNcHIJ8GBebC/MC/fpSchkiM2XuHCuMvzsYfYqPHuD9Zta
         EN8xX7+XOTxw32WEdg6OW+wLd3DFfjCJLpyBvyZ0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NWGgHzDrZmGf; Tue,  7 Jan 2020 14:26:36 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 75A708EE0F8;
        Tue,  7 Jan 2020 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578435995;
        bh=IMwRDmGBJbMcQP14oVqjfwTGrqu/1b1ETWng9igb/ss=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wiUc3vsS64nLiJ0cRdS79Lsx8HWNfZa9Xl3qOpo9AgeDwziuX4gIBIXi1ZZK9RhPz
         fob/JESBLUVg2gquFJgoqMHmZejSNqhHtKvHXfvNdxMTFv3XJ1Vh+JZRn4+qmS3+mh
         0STbBfMPaZjP0f4lOMsC0zE0QJ7kBYi3st9PXLa4=
Message-ID: <1578435994.4288.9.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/4] IMA: Define an IMA hook to measure keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 07 Jan 2020 14:26:34 -0800
In-Reply-To: <20200107194350.3782-2-nramas@linux.microsoft.com>
References: <20200107194350.3782-1-nramas@linux.microsoft.com>
         <20200107194350.3782-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-07 at 11:43 -0800, Lakshmi Ramasubramanian wrote:
[...]
> diff --git a/security/integrity/ima/Kconfig
> b/security/integrity/ima/Kconfig
> index 838476d780e5..73a3974712d8 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -310,3 +310,12 @@ config IMA_APPRAISE_SIGNED_INIT
>  	default n
>  	help
>  	   This option requires user-space init to be signed.
> +
> +config IMA_MEASURE_ASYMMETRIC_KEYS
> +	bool "Enable measuring asymmetric keys on key create or
> update"

I don't believe there's a need to expose this to the person configuring
the kernel, is there?  It's just one more option no-one really wants to
have to understand.  Without the text following bool and the help, this
becomes a hidden config option, which is what I think it should be.

> +	depends on IMA=y

Not that it matters, but IMA is a bool, so this can be simply depends
on IMA

> +	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y

We only need the =y here becase the variable is a tristate, so this
becomes n for both the n and m cases.

> +	default y
> +	help
> +	   This option enables measuring asymmetric keys when
> +	   the key is created or updated.

And drop the help entry.  For future information, help text must be tab
followed by two spaces, not three ... checkpatch doesn't actually catch
this, unfortunately.

James

