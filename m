Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F60BC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7136A21556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wH4NqBip";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wH4NqBip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfLLUyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:54:49 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52324 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730864AbfLLUyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:54:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 796758EE18E;
        Thu, 12 Dec 2019 12:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576184088;
        bh=YU6QhrxSndpTBGBIa+4RwktoTUzIONHARFx7ySfhOjc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wH4NqBipmvzod84QBeGHgRbHIz4DkFcarkwsYQQj8Npq1ZfLhIDxbiHLWSf1ubN0L
         X3HhN14GEwfkjTJP7zPZN75Xn8KRS06NMiNER0JCI/5lw0EW6/2HNeDckqJI8uHXre
         9Zf7hLn87CieqGDvl+9CP8IaWYeMhB40boYNfvqE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bv6xuswA6MId; Thu, 12 Dec 2019 12:54:48 -0800 (PST)
Received: from [9.232.197.95] (unknown [129.33.253.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5CDA18EE0C7;
        Thu, 12 Dec 2019 12:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576184088;
        bh=YU6QhrxSndpTBGBIa+4RwktoTUzIONHARFx7ySfhOjc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wH4NqBipmvzod84QBeGHgRbHIz4DkFcarkwsYQQj8Npq1ZfLhIDxbiHLWSf1ubN0L
         X3HhN14GEwfkjTJP7zPZN75Xn8KRS06NMiNER0JCI/5lw0EW6/2HNeDckqJI8uHXre
         9Zf7hLn87CieqGDvl+9CP8IaWYeMhB40boYNfvqE=
Message-ID: <1576184085.10287.13.camel@HansenPartnership.com>
Subject: Re: [PATCH =v2 3/3] tpm: selftest: cleanup after unseal with wrong
 auth/policy test
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        mingo@redhat.com, jeffrin@rajagiritech.edu.in,
        linux-integrity@vger.kernel.org, will@kernel.org, peterhuewe@gmx.de
Date:   Thu, 12 Dec 2019 15:54:45 -0500
In-Reply-To: <c3bffb8c-d454-1f53-7f7e-8b65884ffaf6@intel.com>
References: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1>
         <157617293957.8172.1404790695313599409.stgit@tstruk-mobl1>
         <1576180263.10287.4.camel@HansenPartnership.com>
         <c3bffb8c-d454-1f53-7f7e-8b65884ffaf6@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-12-12 at 12:49 -0800, Tadeusz Struk wrote:
> On 12/12/19 11:51 AM, James Bottomley wrote:
> > TPM2_Clear reprovisions the SPS ... that would make all currently
> > exported TPM keys go invalid.  I know these tests should be
> > connected to a vTPM, so doing this should be safe, but if this
> > accidentally got executed on your laptop all TPM relying functions
> > would be disrupted, which doesn't seem to be the best thing to hard
> > wire into a test.
> 
> That is true, but it will need to be executed as root, and root
> should know what she/he is doing ;)

Not in the modern kernel resource manager world: anyone who is in the
tpm group can access the tpmrm device and we haven't added a dangerous
command filter like we promised we would, so unless they have actually
set lockout or platform authorization, they'll find they can execute it


> > What about doing a TPM2_DictionaryAttackLockReset instead, which is
> > the least invasive route to fixing the problem ... provided you
> > know what the lockout authorization is.
> 
> I can change tpm2_clear to tpm2_dictionarylockout -c if we want to
> make it foolproof. In this case we can assume that the lockout auth
> is empty.

Well, if it isn't TPM2_Clear would refuse to execute as well since that
requires either lockout auth or platform + physical presence.

James

