Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B508C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9D6206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoRGZRmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfC0RQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:16:02 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36187 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfC0RQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:16:02 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so1409982itl.1;
        Wed, 27 Mar 2019 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HENEyDmJZGOh65ItVsa8GK+oMLDtRRD6rVwzbFATzko=;
        b=ZoRGZRmWyn0OMiisZgFMcK7u0lWc9fOj4z/8TTaiiz8SozvzBG2e8EueF0w5MmnP/y
         mG58L6FnRi75hrECtPHTlDlO7SY2gbOh5mGJeb9PA2fkwTGqOZtXrUHOSCx9eL+Bg6AP
         angbFGsXcP8RaifF09upcJ6cxPM6Y6cs/pLW1kI7c5J2NV5uYTSUz+tr/Baz/TYx7x2E
         F6NCF3dIxfNN6IALvuprTV4P+OyTkeWD+uXxBK+POjOIukZiAxyI+tHuEeRhnLLJg7p1
         e9VFYO+fTLXxN0+0EnUyUdM3UbX2IX2w3VKgFZsz+coaJWhoYq9QfV1Q9bi53Pmup2pS
         C2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HENEyDmJZGOh65ItVsa8GK+oMLDtRRD6rVwzbFATzko=;
        b=CPmm0iMgcu94Z2PMU7ZAJIFe1UE5e4s51tHemWH/uygoyj478P4GBDSzmg13809ipf
         VL3gRAu14eJa5SOh4gT55qQjtE+zSqDBm6fGrGgmOm38zqx0Wypmu2K39XAc0rK9evyd
         EjEOENaWI4ftv3/HJEH7BSu4j3VX4RY/3omQFGIiWLtRwO3bFtOShGWQFRRAtTEwFDHU
         jbMMEXM8p4ys18dzVt0V/rUPHOPfOW8xD0YUeg1ISXG1pgdOWiILobqsC9lMN2RdVuIM
         grPZgDreXsot09J6gHedDRVLRIsrbUXRSNXusvmHk4nfXQ4Ia8dWg5JyuO2rI3W7e9ZH
         bUJg==
X-Gm-Message-State: APjAAAXMwl6PhT4K7jLeRAh7h5PnEsKg0ZOM1VO0ccgK+oRNqK+U210k
        tuRPj0s3BKz9v6tc76bCRm6yLcXAjiuROnMmVmg=
X-Google-Smtp-Source: APXvYqyakiXPGUqoHl2Gn45TNzKO7wPZBQTv0gaRsMmtEc3WTtFkpgS8Xgj0ftK396Bx6ksLfEFdWA/yU5I1QrkQ9P4=
X-Received: by 2002:a02:6d12:: with SMTP id m18mr28569551jac.54.1553706961262;
 Wed, 27 Mar 2019 10:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190326121158.13499-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190326121158.13499-1-jarkko.sakkinen@linux.intel.com>
From:   Dan Williams <dan.j.williams@gmail.com>
Date:   Wed, 27 Mar 2019 10:15:50 -0700
Message-ID: <CAA9_cmfFpkBLz6TU0sLSV1JYE43sDtfi29Xw4R5Xt-RaWm8ZLA@mail.gmail.com>
Subject: Re: [PATCH v3] KEYS: trusted: allow trusted.ko to initialize w/o a TPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linuxibm.com>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 5:13 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Allow trusted.ko to initialize w/o a TPM. This commit adds checks to the
> key type callbacks and exported functions to fail when a TPM is not
> available.
>
> Cc: James Morris <jmorris@namei.org>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> v3:
> - remove unnecessary check for chip in init_trusted()

v3 also tests ok here.
