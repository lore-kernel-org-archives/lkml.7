Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30729C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0024120651
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389468AbfDRPOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:14:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43244 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:14:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id i68so1909892lfi.10;
        Thu, 18 Apr 2019 08:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ja2XnzNSnNoq3rGy2qbSA/3XbMrlUk2CB7PPcq7e1xc=;
        b=s17nwBS4/9P9n0JWOXhTI+JJB34UxE5ls/JwCE16cniZy4AHvKK1vsSDXZ4pZeQJ3c
         1BjRhNAW+X6TMj3mqkbs6n2FrO/JSZ/fNGOfrXGjazw8XWh1MaToUupm7iFVcPSXlkyo
         rHHvkobnqFIrtDU5nHeWgGzAmlr5rYy20dSOZ078Y+s82/cDPcha+ZMLBFjmJdwwBGYI
         kx+wXhrMAU6TvWB4xjnl/IzVFX34oPDeQPL1pGWAzTI35JUVNkdijumV4Xae8l+6taQW
         kPYuxMPSJOvCvri5gRWoDRaj04cdth0svzgA4AjSgz175Lty6Fxl0z/r44QKzpcMfPRk
         k4XQ==
X-Gm-Message-State: APjAAAXWoBJ3LOvWimXextsw3TPR9hG0Wk9jRG0rGS6NmpptJuTBx1wQ
        kdc0hMeYRCIl3V/Q9Nrh0PMdfBDYZvMVO4tGA7Y=
X-Google-Smtp-Source: APXvYqzAWSvBwPwdd2fdHbbzvrUmPpoG7/iU4XeTf48ZpCNE9KilkiuIFov0aDPcv+0oVaMhM86BivjgAWDks9siczU=
X-Received: by 2002:ac2:420b:: with SMTP id y11mr53081771lfh.104.1555600479501;
 Thu, 18 Apr 2019 08:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190416202013.4034148-1-arnd@arndb.de> <20190416202013.4034148-3-arnd@arndb.de>
 <20190417211303.GU2217@ZenIV.linux.org.uk> <CAK8P3a1tiRew6uqegUXsKbNQG7=sPVFMY3yXf0M7OjJdkxM=_g@mail.gmail.com>
 <20190417235300.GB2217@ZenIV.linux.org.uk>
In-Reply-To: <20190417235300.GB2217@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Apr 2019 17:14:21 +0200
Message-ID: <CAK8P3a06NdTDVpDn-KWmdc4_562Ge=hYe2Zw39mx5s0FP+KD6Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/26] compat_ioctl: move simple ppp command handling
 into driver
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Ostrowski <mostrows@earthlink.net>,
        Dmitry Kozlov <xeb@mail.ru>,
        James Chapman <jchapman@katalix.com>,
        linux-ppp@vger.kernel.org, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 1:53 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Apr 18, 2019 at 12:03:07AM +0200, Arnd Bergmann wrote:
> > On Wed, Apr 17, 2019 at 11:13 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Tue, Apr 16, 2019 at 10:19:40PM +0200, Arnd Bergmann wrote:
> > > > diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> > > > index c708400fff4a..04252c3492ee 100644
_ptr(arg) to ppp_ioctl() and be done with that
> > > }
> > >
> > > with BPF-related bits (both compat and native) taken to e.g. net/core/bpf-ppp.c,
> > > picked by both generic and isdn?  IDGI...
> >
> > I was trying to unify the native and compat code paths as much
> > as possible here. Handling the four PPPIO*32 commands in
> > compat_ppp_ioctl would either require duplicating large chunks
> > of ppp_ioctl, or keeping the extra compat_alloc_user_space()
> > copy from the existing implementation.
> >
> > I'll try to come up with a different way to structure the patches.
>
> Huh?  Instead of
>         case PPPIOCSCOMPRESS:
>                 err = ppp_set_compress(ppp, arg);
>                 break;
> in native, have
>         struct ppp_option_data data;
> ...
>         case PPPIOCSCOMPRESS:
>                 if (copy_from_user(&data, argp, sizeof(data)))
>                         err = -EFAULT;
>                 else
>                         err = ppp_set_compress(ppp, &data);
>                 break;

Right, I ended up with something similar before I saw your message.

> in native and similar in compat, with get_bpf_ppp() replaced
> with call of compat_get_bpf_ppp() and ioctl numbers obviously
> adjusted.  All there is to it...  Helpers obviously shared
> with isdn and yes, all crap gone from fs/compat_ioctl.c...

I would still leave the ISDN side alone, aside from adding
the 64-bit time_t support.

> Why would you want to duplicate large chunks of anything?
> The above is not even compile-tested, but...  I can put
> together a patch if you wish.  Or am I missing something
> here?

I expected that the ppp_compat_ioctl() function would end up
fairly complex, to duplicate the logic before the switch()/case.

What I have now is

static long ppp_compat_ioctl(struct file *file, unsigned int cmd,
unsigned long arg)
{
        struct ppp_file *pf;
        struct ppp *ppp;
        int err = -ENOIOCTLCMD;
        struct ppp_option_data32 data32;
        struct ppp_option_data data;
        void __user *argp = compat_ptr(arg);

        mutex_lock(&ppp_mutex);

        pf = file->private_data;
        if (!pf || pf->kind != INTERFACE)
                goto out;

        ppp = PF_TO_PPP(pf);
        switch (cmd) {
        case PPPIOCSCOMPRESS32:
                if (copy_from_user(&data32, argp, sizeof(data32))) {
                        err = -EFAULT;
                        goto out;
                }

                data.ptr = compat_ptr(data32.ptr);
                data.length = data32.length;
                data.transmit = data32.transmit;

                err = ppp_set_compress(ppp, &data);
                break;

#ifdef CONFIG_PPP_FILTER
        case PPPIOCSPASS32:
                err = compat_get_sock_fprog(&uprog, argp);
                if (err)
                        break;
                err = ppp_set_filter(ppp, &uprog, &ppp->pass_filter);
                break;

        case PPPIOCSACTIVE32:
                err = compat_get_sock_fprog(&uprog, argp);
                if (err)
                        break;
                err = ppp_set_filter(ppp, &uprog, &ppp->active_filter);
                break;
#endif /* CONFIG_PPP_FILTER */

        default:
                break;
        }

out:
        mutex_unlock(&ppp_mutex);

        if (err == -ENOIOCTLCMD)
                err = ppp_ioctl(file, cmd, (unsigned long)compat_ptr(arg));

        return err;
}

Which doesn't look nearly as bad as I had feared, but still is
a larger change to the existing code than what I had before,
so there is a bigger risk that I screwed up somewhere new.

       Arnd
