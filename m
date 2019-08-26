Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47933C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2485F2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpuWqE51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbfHZRoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:44:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41215 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbfHZRoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:44:44 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so39308616ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwvVpT1oUpfrmNJJmsG0tncnKf6cWYXcpRZCvToipU8=;
        b=VpuWqE51rpFASY2s3XWeOx28q/DN6nmZRMMGHiowJGrKlMQmmqmb75253Jwg58zNNs
         smSttCxSxJw4s5NoFeoeGZ4P6r5O5317qTF2mVmwBmU/KiqeDl767A2CpIlrdLhVNcVw
         wEl8hE6WZNfTpBnxSMII3dv+T/bpunyNOmG0M1gDjLadWKlQJcPSbGQjSgH9iCik7kGm
         vGii4TC8XDKvI8BS2iTYZWLFGkF1+XR7K0JeN2bEb1CeZXcHxvQzrLhStO3XcekVomEs
         fUBETzqUtLmWN5d7KxQG2Tin0Y/9wYWEq5mKVxFG4U+KkdChsRkW9kTi1sZId52zvdZl
         pNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwvVpT1oUpfrmNJJmsG0tncnKf6cWYXcpRZCvToipU8=;
        b=U4Q8owX2vFaypeBZ+WcU8iktNrQA6ykkyHc/OUeohhPmFFW5egV0JjeK6dKqPjXfxK
         Ooc0l0Es0tk2YXnp9rSbAIJpu0dgPZw+zfStOgtm3U+MJbOTXJD6Fj3AT+bqglZYWA8h
         heMeVKjsgMPKv8d8E0FrQUOVwiDqfcTrf0la/oruwn+DQRCAif+BI6krYQi63NpxCZoX
         TCHRVkoKWo1Do/ETeGG/ztVSMUqbrzAouPbd8lhDCrNcJuFdqdoJxnxJImh3tJzVL0q+
         tld4IZcgWYf9NbovZDJRDWSkl0cviFOq1xvtbnxoRP3+ZiUfX4l8w04q1qRBN1tl0G5L
         fT0w==
X-Gm-Message-State: APjAAAV7Zo1vaE6Djz9UVlbOOpsyH3nP19+BVVsvIdnawIXOQVLOyqWa
        CoZo30g9pZTuUezCpOb9fPiZI5Qh+6EDQ8QfHUJQ3w==
X-Google-Smtp-Source: APXvYqzTkrP6wPdElkAwQ8BNk1dvlidtBN/v9J8swrvxEEGT75u29yQXpPShFLsjxPNKZYU88YmYZkXgkv6JTJTD2Wk=
X-Received: by 2002:a5e:9404:: with SMTP id q4mr3975008ioj.46.1566841483000;
 Mon, 26 Aug 2019 10:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190826153028.32639-1-pjones@redhat.com> <20190826162823.4mxkwhd7mbtro3zy@linux.intel.com>
In-Reply-To: <20190826162823.4mxkwhd7mbtro3zy@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 26 Aug 2019 10:44:31 -0700
Message-ID: <CACdnJuuB_ExhOOtA8Uh7WO42TSNfRHuGaK4Xo=5SbdfWDKr7wA@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi+tpm: Don't access event->count when it isn't mapped.
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 9:28 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Aug 26, 2019 at 11:30:27AM -0400, Peter Jones wrote:
> > Some machines generate a lot of event log entries.  When we're
> > iterating over them, the code removes the old mapping and adds a
> > new one, so once we cross the page boundary we're unmapping the page
> > with the count on it.  Hilarity ensues.
> >
> > This patch keeps the info from the header in local variables so we don't
> > need to access that page again or keep track of if it's mapped.
> >
> > Signed-off-by: Peter Jones <pjones@redhat.com>
> > Tested-by: Lyude Paul <lyude@redhat.com>
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Matthew Garrett <mjg59@google.com>

Jarkko, these two should probably go to 5.3 if possible - I
independently had a report of a system hitting this issue last week
(Intel apparently put a surprising amount of data in the event logs on
the NUCs).
