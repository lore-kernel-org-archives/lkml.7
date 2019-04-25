Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C12C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 04:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23A8217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 04:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfDYE2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 00:28:04 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38915 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDYE2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 00:28:04 -0400
Received: by mail-it1-f194.google.com with SMTP id e13so10084967itk.4;
        Wed, 24 Apr 2019 21:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDpu47ERYkRS1/GfGnF5M+MCg75ZC/pCW4RKSXlFkd4=;
        b=eqPvUuWlvaq7GKHCQ5bInvyKtss1NEGgSxXb4vaiH/SV64rRldYFvHhyGCpg3GwsSy
         fuZ1CcCZqxvZan+Tfe9v9ZnxkWePZqHACdJYaRBBrWhLqbXUSYnp4JKlq2r0cp4kMzmf
         GdglOXK2DEuk2AJqUy9YH938Mh2MOPwm32+j4mGTDoFvHI2ubnjpj5Ujz0SyzitrAFJv
         cLe51UfTET/UX1dTPiD8rdzRFuDZu7PTS2jbtgyAqedJQX45jjMkZppiNlLtapTNMhks
         lhZun/YMHSijyslwZTQqtY53jepC42EPbL79MJ12SObge6zaMAkUXIDNN7NADJS8DIib
         MIXw==
X-Gm-Message-State: APjAAAXqRfLutOdXtVjMFp0n8RCdzqx8jfW4gUIrq2AkwJP9Zg+7M2mv
        XW+ScTjwUm2qOH8mP4NjxV9URdv5
X-Google-Smtp-Source: APXvYqy3+2+3SRiODdKMDF0V/EdAywlsh8slqfOi8P3r0NFFUuKjRqC/h0TDHVv/PvxeSPkADWwUYA==
X-Received: by 2002:a24:4d85:: with SMTP id l127mr2402238itb.53.1556166482761;
        Wed, 24 Apr 2019 21:28:02 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id x187sm9755242itb.39.2019.04.24.21.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 21:28:02 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id r10so13917915ioc.8;
        Wed, 24 Apr 2019 21:28:02 -0700 (PDT)
X-Received: by 2002:a5e:de4d:: with SMTP id e13mr12164061ioq.39.1556166481781;
 Wed, 24 Apr 2019 21:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk>
 <155612245200.8564.4960129218705025182.stgit@warthog.procyon.org.uk>
In-Reply-To: <155612245200.8564.4960129218705025182.stgit@warthog.procyon.org.uk>
From:   Andrew Zaborowski <andrew.zaborowski@intel.com>
Date:   Thu, 25 Apr 2019 06:27:50 +0200
X-Gmail-Original-Message-ID: <CAOq732KsRiXtGD9Wj-iGB77pqJbprCiuDKy_Ypi=dLfvn_9QNQ@mail.gmail.com>
Message-ID: <CAOq732KsRiXtGD9Wj-iGB77pqJbprCiuDKy_Ypi=dLfvn_9QNQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] keys: Add a 'recurse' flag for keyring searches
To:     David Howells <dhowells@redhat.com>
Cc:     ebiederm@xmission.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwalsh@redhat.com, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 at 18:14, David Howells <dhowells@redhat.com> wrote:
> Add a 'recurse' flag for keyring searches so that the flag can be omitted
> and recursion disabled, thereby allowing just the nominated keyring to be
> searched and none of the children.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  Documentation/security/keys/core.rst     |   10 ++++++----
>  certs/blacklist.c                        |    2 +-
>  crypto/asymmetric_keys/asymmetric_type.c |    2 +-
>  include/linux/key.h                      |    3 ++-
>  lib/digsig.c                             |    2 +-
>  net/rxrpc/security.c                     |    2 +-
>  security/integrity/digsig_asymmetric.c   |    4 ++--
>  security/keys/internal.h                 |    1 +
>  security/keys/keyctl.c                   |    2 +-
>  security/keys/keyring.c                  |   12 ++++++++++--
>  security/keys/proc.c                     |    3 ++-
>  security/keys/process_keys.c             |    3 ++-
>  security/keys/request_key.c              |    3 ++-
>  security/keys/request_key_auth.c         |    3 ++-
>  14 files changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
> index 9521c4207f01..99079b664036 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -1159,11 +1159,13 @@ payload contents" for more information.
>
>         key_ref_t keyring_search(key_ref_t keyring_ref,
>                                  const struct key_type *type,
> -                                const char *description)
> +                                const char *description,
> +                                bool recurse)
>
> -    This searches the keyring tree specified for a matching key. Error ENOKEY
> -    is returned upon failure (use IS_ERR/PTR_ERR to determine). If successful,
> -    the returned key will need to be released.
> +    This searches the specified keyring only (recurse == false) or keyring tree
> +    (recurse == true) specified for a matching key. Error ENOKEY is returned
> +    upon failure (use IS_ERR/PTR_ERR to determine). If successful, the returned
> +    key will need to be released.
>
>      The possession attribute from the keyring reference is used to control
>      access through the permissions mask and is propagated to the returned key
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 3a507b9e2568..181cb7fa9540 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -128,7 +128,7 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_len, const char *type)
>         *p = 0;
>
>         kref = keyring_search(make_key_ref(blacklist_keyring, true),
> -                             &key_type_blacklist, buffer);
> +                             &key_type_blacklist, buffer, false);
>         if (!IS_ERR(kref)) {
>                 key_ref_put(kref);
>                 ret = -EKEYREJECTED;
> diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
> index 69a0788a7de5..084027ef3121 100644
> --- a/crypto/asymmetric_keys/asymmetric_type.c
> +++ b/crypto/asymmetric_keys/asymmetric_type.c
> @@ -87,7 +87,7 @@ struct key *find_asymmetric_key(struct key *keyring,
>         pr_debug("Look up: \"%s\"\n", req);
>
>         ref = keyring_search(make_key_ref(keyring, 1),
> -                            &key_type_asymmetric, req);
> +                            &key_type_asymmetric, req, true);
>         if (IS_ERR(ref))
>                 pr_debug("Request for key '%s' err %ld\n", req, PTR_ERR(ref));
>         kfree(req);
> diff --git a/include/linux/key.h b/include/linux/key.h
> index b39f5876b66d..bdd179169508 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -333,7 +333,8 @@ extern int keyring_clear(struct key *keyring);
>
>  extern key_ref_t keyring_search(key_ref_t keyring,
>                                 struct key_type *type,
> -                               const char *description);
> +                               const char *description,
> +                               bool no_recurse);

No functional difference but it's "recurse" everywhere else.

Best regards
