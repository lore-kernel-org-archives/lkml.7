Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6FEC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4383B2146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJtp1S7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfGAP6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:58:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34014 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfGAP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:58:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id y198so833626lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e81E/ko3LJmCEpD4MXZTen4sbl8whJVU0nJ9idHhAP0=;
        b=cJtp1S7sXiZlY3dfkxxivVwU/JMH10aQ1E0Wv4JuPDgywEa9jJQG/7dZ04u6Fh3TWX
         dwZirShZRXpIV44J9j0ODM4xfZ/46cjcYnd1gLCnxr2dR1G6INpsBUQyX0dvVA9eUKEk
         h973rZ6Gf6PE0mIwGLYzKBGS4jg+0LrPVOZh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e81E/ko3LJmCEpD4MXZTen4sbl8whJVU0nJ9idHhAP0=;
        b=eataIJThHw83WUUjQhWMsz0zYOICZ/mV2G/VyV1Edslwm/fP1K8lCCgYhaRTfyqgIT
         KPppu6u+oo7hfwXYgAdnOeRItu4/gy4eD2OblmfOXL6WxcMq8HOQmCb1TCR2oOCLFznU
         Qj5tRuhoMEuKAOzU+XLY/kPvQW5uQO6s1ByydavpUhK7L8pVL6xwJ7ptNOvEmQhuxsUZ
         Nn4Hsd8QzZ97SF/jYB2MIYqgAhCjeW4/zjf0e1pIEYWgG48KFDJmZGAQiIRrZNraDIiM
         aNXUAoLT7SR2XDVUlAx9/ugyyy0XEyNmVJjsD5svp7Xj2mQqvkteqZOYEbdzH5Iv8gJT
         oacA==
X-Gm-Message-State: APjAAAW29XD8oM6qgu9Ug1pK/vD5XQRXez00fm+P3IuW0GqNoK7qGU3W
        rnZs8Is2xEwJ8FwEqZtAwh6rCHoCNwE=
X-Google-Smtp-Source: APXvYqzOGBmn56Fc9I32vpg2Bp9OQTc800YZgGuBQOOkrlVAJ0TLiOc+TxXAjG+lTNSkiVPTNF8CTg==
X-Received: by 2002:ac2:4243:: with SMTP id m3mr7075104lfl.9.1561996680394;
        Mon, 01 Jul 2019 08:58:00 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d4sm2613406lfi.91.2019.07.01.08.57.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 08:57:59 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 136so9145212lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 08:57:59 -0700 (PDT)
X-Received: by 2002:a19:3f16:: with SMTP id m22mr11771250lfa.104.1561996678581;
 Mon, 01 Jul 2019 08:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190626212220.239897-1-evgreen@chromium.org> <20190626212220.239897-2-evgreen@chromium.org>
 <s5hlfxh6e4p.wl-tiwai@suse.de>
In-Reply-To: <s5hlfxh6e4p.wl-tiwai@suse.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 1 Jul 2019 08:57:21 -0700
X-Gmail-Original-Message-ID: <CAE=gft43b6RsLMO9LDSD+uhomr4pV9-WFs5aB1u5Z=q-zsV-hQ@mail.gmail.com>
Message-ID: <CAE=gft43b6RsLMO9LDSD+uhomr4pV9-WFs5aB1u5Z=q-zsV-hQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: hda: Fix widget_mutex incomplete protection
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>,
        "Amadeusz S*awi*ski" <amadeuszx.slawinski@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 7:09 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 26 Jun 2019 23:22:19 +0200,
> Evan Green wrote:
> >
> > The widget_mutex was introduced to serialize callers to
> > hda_widget_sysfs_{re}init. However, its protection of the sysfs widget array
> > is incomplete. For example, it is acquired around the call to
> > hda_widget_sysfs_reinit(), which actually creates the new array, but isn't
> > still acquired when codec->num_nodes and codec->start_nid is updated. So
> > the lock ensures one thread sets up the new array at a time, but doesn't
> > ensure which thread's value will end up in codec->num_nodes. If a larger
> > num_nodes wins but a smaller array was set up, the next call to
> > refresh_widgets() will touch free memory as it iterates over codec->num_nodes
> > that aren't there.
> >
> > The widget_lock really protects both the tree as well as codec->num_nodes,
> > start_nid, and end_nid, so make sure it's held across that update. It should
> > also be held during snd_hdac_get_sub_nodes(), so that a very old read from that
> > function doesn't end up clobbering a later update.
>
> OK, right, this fix is needed no matter whether to take my other
> change to skip hda_widget_sysfs_init() call in
> hda_widget_sysfs_reinit().
>
> However...
>
> > While in there, move the exit mutex call inside the function. This moves the
> > mutex closer to the data structure it protects and removes a requirement of
> > acquiring the somewhat internal widget_lock before calling sysfs_exit.
>
> ... this doesn't look better from consistency POV.  The whole code in
> hdac_sysfs.c doesn't take any lock in itself.  The protection is
> supposed to be done in the caller side.  So, let's keep as is now.

Ok.

>
> Also...
>
> >       codec->num_nodes = nums;
> >       codec->start_nid = start_nid;
> >       codec->end_nid = start_nid + nums;
> > +     mutex_unlock(&codec->widget_lock);
> >       return 0;
> > +
> > +unlock:
> > +     mutex_unlock(&codec->widget_lock);
> > +     return err;
>
> There is no need of two mutex_unlock() here.  They can be unified,
>
>         codec->num_nodes = nums;
>         codec->start_nid = start_nid;
>         codec->end_nid = start_nid + nums;
>   unlock:
>         mutex_unlock(&codec->widget_lock);
>         return err;
>
> Could you refresh this and resubmit?

Sure, will do. Thanks for taking a look.
