Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813BFC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B85E208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="a0kldUnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfFQJ6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:58:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41908 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfFQJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:58:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id s21so8658127lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=iKqfthJLs1khkBsV+9UVzZvxk7yU7AKPa89YLxvDkt8=;
        b=a0kldUnvCzKXA0fC7dVwmGOliSB+fCQqJBomISMdL+7z7eXfU/C6p7XF6xdLk7EPX0
         H7tNMTneARolfMaUFdZscMu9rEbV+6psTYYJox+ZkcF5sFgo8+TASmCB9RrwXhw7+QGg
         /4hWtWE22KHRVq1BQ0XW00zQniaOnOO2Kn83pdpoCmgmhvlOsVwSAKPGUrIQxjQs75rm
         3BAqjxkxHlQUg7AnIu1p/Us3tvhat1nRcYBzHjhK8tJ5Yy+Xjvby3DHd9WoS95Bo6RgD
         6T5wNIyWCV+C9u7zfbKL8Zc0zmHZxf46Xeg93K4AlDHUh7iMYnx/xR+pF0MGLsEnda9F
         BYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=iKqfthJLs1khkBsV+9UVzZvxk7yU7AKPa89YLxvDkt8=;
        b=Z4AXFVqw3MFZLNaYq0u80LewraTtOdYnHjQ8hDgdhSZ5psQf9bRZ03IYEQRRx09XEB
         j35Lo01igkqkt6SVMf6KDJdaOSqBmRcfE041+gs0IhNQjWM0nrAxZjW9C4qV0QvfFN7q
         umj7EOYgQwFuoFfzs2A/1M5XWwI1peJ6SLBJjFzSbBhNMBwIj0aadkctG4WZAll5LMqw
         xC+YUgU3wWxzhm1NDSYatsZ7vIGkmc9SnGqNtyCSS5uSzh7B/7Jtwv11bjvICTn60iJ9
         7xQ5HWGdjnp0ZOQQj4XG1nWF8CEvhK8vjxV8uQeEaeDrWEe3t3+lzVFDUdzmHPUD5wOa
         Uzng==
X-Gm-Message-State: APjAAAXuvDEu79166n0c/8werWwzBD3s/0JJOJbwqh3HMkqPxOtedKFe
        BzUP1Xh487haArZ8pCSv93qmMiKPERRHh2VJGi1wD+dNmtpu1w==
X-Received: by 2002:a2e:8847:: with SMTP id z7mt10098339ljj.51.1560765529616;
 Mon, 17 Jun 2019 02:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190617073320.69015-1-lifei.shirley@bytedance.com>
 <28bef625-ce70-20a1-7d8b-296cd43015c4@redhat.com> <2d05dce3-e19a-2f0f-8b74-8defae38640d@redhat.com>
In-Reply-To: <2d05dce3-e19a-2f0f-8b74-8defae38640d@redhat.com>
From:   =?UTF-8?B?5p2O6I+y?= <lifei.shirley@bytedance.com>
Date:   Mon, 17 Jun 2019 17:58:38 +0800
Message-ID: <CA+=e4K6G0apU2psFYDtFDbpE14nfBB_sD_Y2rK-v3=nYPO8B3Q@mail.gmail.com>
Subject: Re: [External Email] Re: [PATCH] Fix tun: wake up waitqueues after
 IFF_UP is set
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thanks for the detail suggestion! :)


On Mon, Jun 17, 2019 at 4:16 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/6/17 =E4=B8=8B=E5=8D=884:10, Jason Wang wrote:
> >
> > On 2019/6/17 =E4=B8=8B=E5=8D=883:33, Fei Li wrote:
> >> Currently after setting tap0 link up, the tun code wakes tx/rx waited
> >> queues up in tun_net_open() when .ndo_open() is called, however the
> >> IFF_UP flag has not been set yet. If there's already a wait queue, it
> >> would fail to transmit when checking the IFF_UP flag in tun_sendmsg().
> >> Then the saving vhost_poll_start() will add the wq into wqh until it
> >> is waken up again. Although this works when IFF_UP flag has been set
> >> when tun_chr_poll detects; this is not true if IFF_UP flag has not
> >> been set at that time. Sadly the latter case is a fatal error, as
> >> the wq will never be waken up in future unless later manually
> >> setting link up on purpose.
> >>
> >> Fix this by moving the wakeup process into the NETDEV_UP event
> >> notifying process, this makes sure IFF_UP has been set before all
> >> waited queues been waken up.
>
>
> Btw, the title needs some tweak. E.g you need use "net" as prefix since
> it's a fix for net.git and "Fix" could be removed like:
>
> [PATCH net] tun: wake up waitqueues after IFF_UP is set.
>
> Thanks
>
>
> >>
> >> Signed-off-by: Fei Li <lifei.shirley@bytedance.com>
> >> ---
> >>   drivers/net/tun.c | 17 +++++++++--------
> >>   1 file changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index c452d6d831dd..a3c9cab5a4d0 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -1015,17 +1015,9 @@ static void tun_net_uninit(struct net_device
> >> *dev)
> >>   static int tun_net_open(struct net_device *dev)
> >>   {
> >>       struct tun_struct *tun =3D netdev_priv(dev);
> >> -    int i;
> >>         netif_tx_start_all_queues(dev);
> >>   -    for (i =3D 0; i < tun->numqueues; i++) {
> >> -        struct tun_file *tfile;
> >> -
> >> -        tfile =3D rtnl_dereference(tun->tfiles[i]);
> >> - tfile->socket.sk->sk_write_space(tfile->socket.sk);
> >> -    }
> >> -
> >>       return 0;
> >>   }
> >>   @@ -3634,6 +3626,7 @@ static int tun_device_event(struct
> >> notifier_block *unused,
> >>   {
> >>       struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
> >>       struct tun_struct *tun =3D netdev_priv(dev);
> >> +    int i;
> >>         if (dev->rtnl_link_ops !=3D &tun_link_ops)
> >>           return NOTIFY_DONE;
> >> @@ -3643,6 +3636,14 @@ static int tun_device_event(struct
> >> notifier_block *unused,
> >>           if (tun_queue_resize(tun))
> >>               return NOTIFY_BAD;
> >>           break;
> >> +    case NETDEV_UP:
> >> +        for (i =3D 0; i < tun->numqueues; i++) {
> >> +            struct tun_file *tfile;
> >> +
> >> +            tfile =3D rtnl_dereference(tun->tfiles[i]);
> >> + tfile->socket.sk->sk_write_space(tfile->socket.sk);
> >> +        }
> >> +        break;
> >>       default:
> >>           break;
> >>       }
> >
> >
> > Acked-by: Jason Wang <jasowang@redhat.com)
> >
