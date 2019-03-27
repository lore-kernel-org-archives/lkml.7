Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E58C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4BA2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2EUIIzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfC0CGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:06:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43121 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731754AbfC0CGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:06:49 -0400
Received: by mail-io1-f67.google.com with SMTP id x3so12684633iol.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eytzmU3NjxhNAmdOvQPC50LlttNGV7pwuE1zw4whqVI=;
        b=q2EUIIzTykBEMtSnWLridd0u3y82nmK06qLFYUPWPC0C+SMZbCzk4jviDLmBAScw+Y
         bJHUU8r57DetwRYdly6OrA2+Xo3OTf6LMPpgzb5yhbsjcTH5fP8aBvrkMjADkLNkyISd
         GygKY0ZKbdNfgQ0AOtQ8UexiWeU58vOLd/m8BF48lJ3v5sMtx9fi/vAYZUWB/o1iW05t
         Fw9pZpnBiS2ROesTYykBjM/ALh3BmjVrVM2G4oLHmLIa81yg8bHjSLXU1tA68kcAsgA4
         vN9q2ihFOjxXnS9ZAFPNunNPKA+Gug+Wawd2eWowSKHcmFVfboJRu1iSAvyuC/iMbKmc
         F7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eytzmU3NjxhNAmdOvQPC50LlttNGV7pwuE1zw4whqVI=;
        b=rJzj4tVc7JsYq6sOhuDoyQE3jjcKVzmHvgp67QUPme/eLQYmLRwNiZLbNFebRBZQX0
         XdRnlMgbY8aTl+IHeBNwLvv9sWaK43/0503U3272zdnH2NNo+DbfKdwJQBJ1CGLSpakG
         fe7Tb6D1tk+JLpWpMw8OkOmgZzbVhTjgBaViTLiK9tobfkNyy3MwHnZTpjFSPt6vcQwr
         arfyJdb6RD2vVhoyPKSqU3H5cWjZXQviFTdke1MbSA3AqfLNdVgRHCf0eIAFRb8mnsLf
         C1B7H3B7g1nTEEEwo8IXjdSEuKKVOtACR/ke7e9kjkb6LBBL3G3SrDQZOeqb1E8hlz3P
         BupQ==
X-Gm-Message-State: APjAAAVp6JyZcWwi/8mJYYroYGvvjH0JYyjusvM8IIdKRkOIoGDE9RQf
        XH43hxSYVIe+NJF2aCfiYM/M+zhNbHkq9diVvdKBMwxneVE=
X-Google-Smtp-Source: APXvYqzSk/MoMyjFEj2oL3GW9b1r8guh+8rGuSgVfOXqrLf/LwHIxj2PDgYiasOmqU9zE3TjJem+1b/qBTBoJXtdELU=
X-Received: by 2002:a5e:950f:: with SMTP id r15mr14117601ioj.88.1553652408531;
 Tue, 26 Mar 2019 19:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com> <20190327003130.GB27311@kroah.com>
In-Reply-To: <20190327003130.GB27311@kroah.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 26 Mar 2019 19:06:36 -0700
Message-ID: <CACdnJuvBJmCRnzT=4qh9cmNkRNHi3Xfha5xqUqYu8cgCRrtsqQ@mail.gmail.com>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked down
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 5:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 26, 2019 at 11:27:41AM -0700, Matthew Garrett wrote:
> > From: Matthew Garrett <mjg59@google.com>
> >
> > debugfs has not been meaningfully audited in terms of ensuring that
> > userland cannot trample over the kernel. At Greg's request, disable
> > access to it entirely when the kernel is locked down. This is done at
> > open() time rather than init time as the kernel lockdown status may be
> > made stricter at runtime.

(snip)

> Why allow all this, why not just abort the registering of the filesystem
> with the vfs core so it can't even be mounted?

As mentioned in the commit message, because the lockdown state can be
made stricter at runtime - blocking at mount time would be
inconsistent if the machine is locked down afterwards. We could
potentially assert that it's the admin's responsibility to ensure that
debugfs isn't mounted at the point of policy being made stricter?
