Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB049C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959DC206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/bN7OD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfC2EGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:06:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45700 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfC2EGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:06:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id y84so621209oia.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 21:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E99/uDmEWiANrLfG/9dDK6an3z4rD0PRA3vgayXozKU=;
        b=M/bN7OD8LEBlR3l3ADqC3eSZyjwZWmAhXdFmhR8g2fPLnn3TONVkGx3baOW76e2s9m
         o9SKaECoEe2c4Mxx/Le8fFluvhCyS6enTskijRnZUGiKYytnbUU8msdfVzdghVCg4OZf
         g6OSzl19jMlzE5jiNnQQEazWVRCSXu1lIzQcDEgICdUWe1oBQhv8UmGF5EHoH6YIdjAR
         gH5rTRGvUjl9A3t4AC1Fwx3geZKsBBNRtmp+Mwu1+jH+SCy72AHLkJrmd6F8g1zqDlKO
         FHv8mvUTjtW2VR+wbFwVp14DhOLPEl06QWB+FMEzHfLtYlPWPxWkPI5HSuKscELILbSu
         Py/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E99/uDmEWiANrLfG/9dDK6an3z4rD0PRA3vgayXozKU=;
        b=oj3SFBj87RV8nboE52mKMk+e8otawfRGsonXgb2cYW25GqtkZvJaLDvteWU7a5J2gL
         Rssjl/xBvi8U1hMzt2daCSkOfTPZ0lLII619a9N1eCfr8I6g4onpBW1do0hxv/WfLMZ4
         lKDzDzJW4eBGgprH4+35iuU+ll40nDfqYU47WUaCt7IfnkGGZHbU54wW3v1if06F1q6F
         X4G/dLnqpz37qUVJtr4HINZepxAN7ov0AqXJup4DAyA59mWb2EqzQdj4cHSmwW5Xzg+r
         Hh6tBjoi7pf6V+3w47uIYlWgD64KnPD3Iv7b46sa4dRfQ+rw+KtZsY4fxtetLoj97zui
         okMQ==
X-Gm-Message-State: APjAAAUCIbvU28lkHap3hAv2jJ/MAgNaePcJJVVJ3Sg8NOtwjZOluNRB
        TtAOzsPIX0cGYsxTTo/ukIo/E9h1GSVi1bmgEdXAEA==
X-Google-Smtp-Source: APXvYqzoLqlpYbhog2LW/zS1D8EL3+eolOXrJDv30oI9SXQr/wBlgGqFy0DLKfVL7j+y6YRWBBCEZnlJ+sF+fFfvc/s=
X-Received: by 2002:aca:e4cc:: with SMTP id b195mr2374186oih.39.1553832407601;
 Thu, 28 Mar 2019 21:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190329024047.206989-1-joel@joelfernandes.org>
In-Reply-To: <20190329024047.206989-1-joel@joelfernandes.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Mar 2019 05:06:21 +0100
Message-ID: <CAG48ez1DrHKG2PoQjdpc=vT55enaRgQpGfAwo5ujV25TLHJL0g@mail.gmail.com>
Subject: Re: [PATCH] doc/rcuref: Document real world examples in kernel
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 3:40 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> Document similar real world examples in the kernel corresponding to the
> second and third code snippets. Also correct an issue in
> release_referenced() in the code snippet example.
>
> Cc: oleg@redhat.com
> Cc: jannh@google.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---
>  Documentation/RCU/rcuref.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.txt
> index 613033ff2b9b..e5f4a49f886a 100644
> --- a/Documentation/RCU/rcuref.txt
> +++ b/Documentation/RCU/rcuref.txt
> @@ -28,7 +28,8 @@ add()                         search_and_reference()
>  release_referenced()                   delete()
>  {                                      {
>      ...                                            write_lock(&list_lock);
> -    atomic_dec(&el->rc, relfunc)           ...
> +    if(atomic_dec_and_test(&el->rc))       ...
> +       kfree(el);
>      ...                                            remove_element
>  }                                          write_unlock(&list_lock);
>                                             ...
> @@ -114,6 +115,11 @@ element can therefore safely be freed.  This in turn guarantees that if
>  any reader finds the element, that reader may safely acquire a reference
>  without checking the value of the reference counter.
>
> +The other advantage of the last pattern is, if there are several calls to
> +search_and_reference() in parallel to the delete(), then all of those will
> +succeed in obtaining a reference to the object if the object could be found in
> +the list before it was deleted in delete().

Isn't this the same as what the previous paragraph said? "if
any reader finds the element, that reader may safely acquire a reference
without checking the value of the reference counter".

>  In cases where delete() can sleep, synchronize_rcu() can be called from
>  delete(), so that el_free() can be subsumed into delete as follows:
>
> @@ -130,3 +136,7 @@ delete()
>         kfree(el);
>      ...
>  }
> +
> +As additional examples in the kernel, This last pattern is also followed by

nit: s/, This/, this/
