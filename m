Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAFCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2A621773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQ0ILm+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfDXWDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:03:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35535 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbfDXWDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:03:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id m10so17644404otp.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 15:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bn3OUTJmlJPWQT/E0ROkV7WHWvQux6ja7FeAyh84pk=;
        b=YQ0ILm+nqbiElLKvILsqtgMxOsBS4praWfV4HoJNyHCAK7ELQUW+WZY9V6zm6LcmHY
         lQ4jtsniQ2OfEg7rqLkXJ8QclyEMUVeqDubqHamXJyFPo/qyAvDt/PfJXM6n7qRMxium
         aNAxXOhBOMyQEla7HExyaMOdIwOtY5SqJAF9PR0CyACj3etC/XFJHlsfsEJLC4sNVbok
         OhXIFZH9S/nMuSIYx7bBWWkGyN5JSgW+M17YS3etBkwtSu+JMbRHAoesTuyhY2bSgZGR
         ys/m80GpxsUKZHFjKsnq8EAbTApg2U2diT3pLE2KinSNxAl2ln+Tf27THHUm0Wtq9gbp
         JiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bn3OUTJmlJPWQT/E0ROkV7WHWvQux6ja7FeAyh84pk=;
        b=U95MJrURqqX6XExAFFXsioMCp4zKWndJ99h7+fuZ4SnYenfYxDz/0ZsdC62PKESs9k
         3ksVP8TPAalZIicAiOzcRtrdUGKFe/bghRjw7GLI1g7dxrj6OCEtwmD6pOQmlOE845We
         mdPOETQqp/WCmfPPNYJqKcNaZyRw0rrrna+xuYjOomxT9Hu99avfAWTaA2X2t58O/2hs
         4V+L7c5lVxl3zQy/BI9zMJUTaudkFOHql1BtFKmgbi8INtQy+1OG1zM8ZxhiNGAr2YwB
         F7Znex8kzMPNcP94gy7CGhYsC7taeJom1mjv6kWEoxmxLng8jpFu7+/8qB+ZgnlyKDrE
         ML1Q==
X-Gm-Message-State: APjAAAU7Oe0J/aMOxl9AeKVg1G+yz2y2T5MXweRjEXN45jSqrWqOQ8wD
        gji8R3gXHU7D6FmIRUZpJs0kPmYyOQxyIMxAYtVMJA==
X-Google-Smtp-Source: APXvYqwKbR4PGqqr7zLogumnZnHe+e9M4cpZl2M7DzPFjMl1gW+2X6ungl71sfVsaYSMJm5O3yIKOV8dWTvvqiN0f0g=
X-Received: by 2002:a05:6830:1216:: with SMTP id r22mr22050253otp.198.1556143418164;
 Wed, 24 Apr 2019 15:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk>
 <155612246750.8564.9186344007442012471.stgit@warthog.procyon.org.uk>
In-Reply-To: <155612246750.8564.9186344007442012471.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 25 Apr 2019 00:03:11 +0200
Message-ID: <CAG48ez23c1eiEJpBwkV183sesj6EDWoMsEh40GDXQkS1W2_nMA@mail.gmail.com>
Subject: Re: [PATCH 07/11] keys: Move the user and user-session keyrings to
 the user_namespace
To:     David Howells <dhowells@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>, dwalsh@redhat.com,
        vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 6:14 PM David Howells <dhowells@redhat.com> wrote:
> Move the user and user-session keyrings to the user_namespace struct rather
> than pinning them from the user_struct struct.  This prevents these
> keyrings from propagating across user-namespaces boundaries with regard to
> the KEY_SPEC_* flags, thereby making them more useful in a containerised
> environment.
>
> The issue is that a single user_struct may be represent UIDs in several
> different namespaces.
>
> The way the patch does this is by attaching a 'register keyring' in each
> user_namespace and then sticking the user and user-session keyrings into
> that.  It can then be searched to retrieve them.

Overall, this looks good to me, apart from some details.

The user_keyring_register keyring is basically just used like an
xarray/idr/... that maps from namespaced UIDs to keyrings, right? (Not
saying it's a bad idea, just want to make sure I understand it
correctly.)

> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 90457015fa3f..44a5a4a8a269 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -67,12 +67,13 @@ struct user_namespace {
>  #ifdef CONFIG_KEYS
>         /* List of joinable keyrings in this namespace */
>         struct list_head        keyring_name_list;
> +       struct key              *user_keyring_register;

Maybe a comment about locking semantics above user_keyring_register?
"Only written once, may be read locklessly with READ_ONCE()", or
something like that?

> +       struct rw_semaphore     keyring_sem;
>  #endif
[...]
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index 70fa20888ca8..ff62d90415ae 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -8,7 +8,7 @@
>   * as published by the Free Software Foundation; either version
>   * 2 of the License, or (at your option) any later version.
>   */
> -
> +#define __KDEBUG

Was that supposed to be in here, or did you commit that accidentally?

[...]
> @@ -39,98 +37,173 @@ struct key_user root_key_user = {
>  };
>
>  /*
> - * Install the user and user session keyrings for the current process's UID.
> + * Get or create a user register keyring.
>   */
> -int install_user_keyrings(void)
> +static struct key *get_user_register(struct user_namespace *user_ns)
>  {
> -       struct user_struct *user;
> -       const struct cred *cred;
> -       struct key *uid_keyring, *session_keyring;
> +       struct key *reg_keyring = user_ns->user_keyring_register;

This is a lockless read of a field that may be written concurrently;
this should be READ_ONCE(). (Especially on alpha, I think the memory
ordering will actually be incorrect without READ_ONCE().)

> +       if (reg_keyring)
> +               return reg_keyring;
> +
> +       down_write(&user_ns->keyring_sem);
> +
> +       /* Make sure there's a register keyring.  It gets owned by the
> +        * user_namespace's owner.
> +        */
> +       reg_keyring = user_ns->user_keyring_register;
> +       if (!reg_keyring) {
> +               reg_keyring = keyring_alloc(".user_reg", user_ns->owner, INVALID_GID,
> +                                           &init_cred,
> +                                           KEY_POS_WRITE | KEY_POS_SEARCH |
> +                                           KEY_USR_VIEW | KEY_USR_READ,
> +                                           0,
> +                                           NULL, NULL);
> +               if (!IS_ERR(reg_keyring))
> +                       user_ns->user_keyring_register = reg_keyring;

This is a write of a pointer that may be read concurrently; this
should be smp_store_release().

> +       }
> +
> +       up_write(&user_ns->keyring_sem);
> +
> +       /* We don't return a ref since the keyring is pinned by the user_ns */
> +       return reg_keyring;
> +}
> +
> +/*
> + * Look up the user and user session keyrings for the current process's UID,
> + * creating them if they don't exist.
> + */
> +int look_up_user_keyrings(struct key **_user_keyring,
> +                         struct key **_user_session_keyring)
> +{
> +       const struct cred *cred = current_cred();
> +       struct user_namespace *user_ns = current_user_ns();
> +       struct key *reg_keyring, *uid_keyring, *session_keyring;
>         key_perm_t user_keyring_perm;
> +       key_ref_t uid_keyring_r, session_keyring_r;
> +       uid_t uid = from_kuid(user_ns, cred->user->uid);
>         char buf[20];
>         int ret;
> -       uid_t uid;
>
>         user_keyring_perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_ALL;
> -       cred = current_cred();
> -       user = cred->user;
> -       uid = from_kuid(cred->user_ns, user->uid);
>
> -       kenter("%p{%u}", user, uid);
> +       kenter("%u", uid);
>
> -       if (READ_ONCE(user->uid_keyring) && READ_ONCE(user->session_keyring)) {
> -               kleave(" = 0 [exist]");
> -               return 0;
> -       }
> +       reg_keyring = get_user_register(user_ns);
> +       if (IS_ERR(reg_keyring))
> +               return PTR_ERR(reg_keyring);
>
> -       mutex_lock(&key_user_keyring_mutex);
> +       down_write(&user_ns->keyring_sem);
>         ret = 0;
>
> -       if (!user->uid_keyring) {
> -               /* get the UID-specific keyring
> -                * - there may be one in existence already as it may have been
> -                *   pinned by a session, but the user_struct pointing to it
> -                *   may have been destroyed by setuid */
> -               sprintf(buf, "_uid.%u", uid);
> -
> -               uid_keyring = find_keyring_by_name(buf, true);
> +       /* Get the user keyring.  Note that there may be one in existence
> +        * already as it may have been pinned by a session, but the user_struct
> +        * pointing to it may have been destroyed by setuid.
> +        */
> +       sprintf(buf, "_uid.%u", uid);

I know that the sprintf() calls here and below can't overrun the
buffer, but it'd be nice if you could use "snprintf(buf, sizeof(buf),
...)" anyway.

[...]
>  }
>
> +/*
> + * Get the user session keyring if it exists, but don't create it if it
> + * doesn't.
> + */
> +struct key *get_user_session_keyring(void)
> +{
> +       const struct cred *cred = current_cred();
> +       struct user_namespace *user_ns = current_user_ns();
> +       struct key *reg_keyring = user_ns->user_keyring_register;

(READ_ONCE() again)

> +       key_ref_t session_keyring_r;
> +       char buf[20];
> +
> +       if (!reg_keyring)
> +               return NULL;
> +
> +       sprintf(buf, "_uid_ses.%u", from_kuid(user_ns, cred->user->uid));
> +
> +       session_keyring_r = keyring_search(make_key_ref(reg_keyring, true),
> +                                          &key_type_keyring, buf, false);
> +       if (IS_ERR(session_keyring_r))
> +               return NULL;
> +       return key_ref_to_ptr(session_keyring_r);
> +}
[...]
> @@ -416,10 +490,9 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
>                 }
>         }
>         /* or search the user-session keyring */
> -       else if (READ_ONCE(cred->user->session_keyring)) {
> -               key_ref = keyring_search_aux(
> -                       make_key_ref(READ_ONCE(cred->user->session_keyring), 1),
> -                       ctx);
> +       else if ((user_session = get_user_session_keyring())) {
> +               key_ref = keyring_search_aux(make_key_ref(user_session, 1),
> +                                            ctx);
>                 if (!IS_ERR(key_ref))
>                         goto found;

I'm not sure I understand this code. In the "goto found" case, the
key_put() below is skipped, right? Is that intentional?

>
> @@ -435,6 +508,8 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
>                         err = key_ref;
>                         break;
>                 }
> +
> +               key_put(user_session);
>         }
>
>         /* no key - decide on the error we're going to go for */
[...]
> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> index 39802540ffff..d95627888f5a 100644
> --- a/security/keys/request_key.c
> +++ b/security/keys/request_key.c
> @@ -96,7 +96,7 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
>         struct request_key_auth *rka = get_request_key_auth(authkey);
>         const struct cred *cred = current_cred();
>         key_serial_t prkey, sskey;
> -       struct key *key = rka->target_key, *keyring, *session;
> +       struct key *key = rka->target_key, *keyring, *session, *user_session;
>         char *argv[9], *envp[3], uid_str[12], gid_str[12];
>         char key_str[12], keyring_str[3][12];
>         char desc[20];
> @@ -104,9 +104,9 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
>
>         kenter("{%d},{%d},%s", key->serial, authkey->serial, rka->op);
>
> -       ret = install_user_keyrings();
> +       ret = look_up_user_keyrings(NULL, &user_session);
>         if (ret < 0)
> -               goto error_alloc;
> +               goto error_us;
>
>         /* allocate a new session keyring */
>         sprintf(desc, "_req.%u", key->serial);
> @@ -144,7 +144,7 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
>
>         session = cred->session_keyring;
>         if (!session)
> -               session = cred->user->session_keyring;
> +               session = user_session;
>         sskey = session->serial;
>
>         sprintf(keyring_str[2], "%d", sskey);
> @@ -187,6 +187,8 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
>
>  error_alloc:
>         complete_request_key(authkey, ret);
> +error_us:
> +       key_put(user_session);
>         kleave(" = %d", ret);
>         return ret;
>  }

This looks weird. If the look_up_user_keyrings() fails, user_session
might still be an uninitialized pointer, right? And then the "goto
error_us" jumps down here and calls key_put() on that?

> @@ -289,16 +291,19 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
>
>                         if (dest_keyring)
>                                 break;
> +                       /* Fall through */
>
>                         /* fall through */
>                 case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:

Why two "fall through" comments?
