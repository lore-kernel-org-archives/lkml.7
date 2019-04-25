Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76269C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8859A2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RDkfmGP5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UoF0oNh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfDYTqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:46:50 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51342 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727517AbfDYTqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:46:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F18BD8EE128;
        Thu, 25 Apr 2019 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556221608;
        bh=eEZhjMHHMxvU2y+hJ2EEU/LgKWzqfVWKCNdD4gxbL5g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RDkfmGP5zG/H0JgXAB+X2uF+VrjXfq1ilzpng22YN2DDEJx4Wv7/YWdCTgQDPXBmf
         OYrob/YZYgA/aLKHZP2R3AT7DK52DExdC9/M1RxOP+Daylk8CBHkhKCYbErckCXPjO
         AcBngFmDW5V+mCpDsPaMHQDjuEQGSaNncFzF6qsQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4c3LLyURmsqg; Thu, 25 Apr 2019 12:46:47 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B90DC8EE0AB;
        Thu, 25 Apr 2019 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556221607;
        bh=eEZhjMHHMxvU2y+hJ2EEU/LgKWzqfVWKCNdD4gxbL5g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UoF0oNh7fo5g1m73NKF5r3a0Yx/4IVVWbxksDv7EBZ+Wh6IbiCsbfcaPSueqemeeM
         gMTk6JEU2/bxF1rdJbwDgivzkX8CF117rb+GUTpNUupXLy6PEnzFKYPxwXEKiCx9Vx
         YqKJLOJZc39uonrCqxq4vcI4n7f+MWfqHn/GJZXo=
Message-ID: <1556221605.24945.3.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] KEYS: Make use of platform keyring for module
 signature verify
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Robert Holmes <robeholmes@gmail.com>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        stable@vger.kernel.org
Date:   Thu, 25 Apr 2019 12:46:45 -0700
In-Reply-To: <1556193350.3894.92.camel@linux.ibm.com>
References: <1556116431-7129-1-git-send-email-robeholmes@gmail.com>
         <1556193350.3894.92.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-25 at 07:55 -0400, Mimi Zohar wrote:
> On Wed, 2019-04-24 at 14:33 +0000, Robert Holmes wrote:
> > This patch completes commit 278311e417be ("kexec, KEYS: Make use of
> > platform keyring for signature verify") which, while adding the
> > platform keyring for bzImage verification, neglected to also add
> > this keyring for module verification.
> > 
> > As such, kernel modules signed with keys from the MokList variable
> > were not successfully verified.
> 
> Using the platform keyring keys for verifying kernel modules was not
> neglected, but rather intentional.  This patch description should
> clearly explain the reason for needing to verify kernel module
> signatures based on the pre-boot keys.  (Hint: verifying kernel
> modules based on the pre-boot keys was previously rejected.)

To clarify here: most Linux systems use shim/mok to pivot the root of
trust away from the Secure Boot db variable to the new MokList/shim
built in keys.  This makes the actual secure boot db outside the
expected Linux Kernel trust boundary *unless* the user has taken
ownership of the system and is actually using db for their own trusted
keys.  This makes the policy for what pre-boot keys to trust within the
Linux boundary very complex, which is why we default to not using the
pre-boot keys at all.

James

