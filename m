Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96892C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCF52086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="oKIcWEte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfDASyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:54:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34888 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728690AbfDASyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:54:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 758698EE12C;
        Mon,  1 Apr 2019 11:54:45 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xYMDqoXhVfSC; Mon,  1 Apr 2019 11:54:45 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A7DA18EE0CD;
        Mon,  1 Apr 2019 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1554144885;
        bh=jywvzMZ3T1LUMchw4h1QJoeQmzI1zyDJABogHdLRFlU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oKIcWEteat8kFuHGz/OoCpFcFXbGgmU+H5SLdNaptS6WmpEHgBYqDpIIMlvxPEwz+
         Yd3/loKr40Al//wRDsBvRVSNjzaxE0URHf9EZdQzn2OQpZSrxSFmdkQvU9Rj71EFxt
         dw+D+XuGiBShlCdQi2IKkXkHmM1eLDRXV8zo4C98=
Message-ID: <1554144883.3029.20.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: Actually fail on TPM errors during "get random"
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kees Cook <keescook@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-integrity@vger.kernel.org
Date:   Mon, 01 Apr 2019 11:54:43 -0700
In-Reply-To: <20190401185219.GA22215@beast>
References: <20190401185219.GA22215@beast>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-01 at 11:52 -0700, Kees Cook wrote:
> @@ -559,6 +559,9 @@ int tpm1_get_random(struct tpm_chip *chip, u8
> *dest, size_t max)
>  	rc = total ? (int)total : -EIO;
>  out:
>  	tpm_buf_destroy(&buf);
> +fail:
> +	if (rc > 0)
> +		rc = -EIO;
>  	return rc;
>  }

No: same problem.  If we're successful rc is set to total (a positive
integer) so as it falls through to fail: it's converted to -EIO which
means we never return success.

James

