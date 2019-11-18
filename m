Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87A7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F6C2230D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUjlQnOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKRVbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:31:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36165 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:31:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id y10so22016541qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YoDER8EbPbrxvTk20j36WpFoZykaOKsuEN5VTEnqZK8=;
        b=BUjlQnOq0+PBXA9VrqWurlJbGZ+QwgvyTVBPOLcY49ZLygOjTAHMxSi6DNOKvCUr42
         iwLn7z2Kc3p7oakGdhlrXmssGfL5xd6IZI34dCybA6+zhBXgH99Hwc04R322ssGhlT4y
         pMj3xP9zJrZm/P5XKseGcDI95VM7neqgq5Q4C6x/2qMOqGTcvAHv+M/nKhcNs0TunL7H
         IViTWyNQVm+mVxY1TYtZY55PtexDCRFl0FmxVwptXeMvTh792ws+4uO4OA9ty0Rq6VST
         Ym2mcaJ24dgO79Qy8vL9ao7dgHPzciYwddG4jfH6qLdjvv1vxsNLjjlz+8q+1chRzchi
         xq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YoDER8EbPbrxvTk20j36WpFoZykaOKsuEN5VTEnqZK8=;
        b=sV5ukWZvz6sBCn2eNMnpYSPbG/M1g/jOgkb1bk3ii3Rm/Z+rdz8v987F/7/3cyivds
         b/zPRhu/5kGMuHfA637Gb0ypZlk+KALHSELYAJuksxUElWaXOLAoEUK+b6Q9r2szHZzi
         1fW+2nyAHSFn+RysIzOC+WV7IQF+Y1jM1MbxrKQW2FgOymbZExVkfyhwHzYOGmut0MnE
         xbfcfbdH+S9fuZGbaIH+17L45l9ZiFpvcmC9/yh3pqazlF18QY/SqExDYax23/LR8Azl
         9wjZbHUCezGsSE2FdGZ04l8ppYlHKS1zgsufPiLunwTa+NBZy79NqoD+aUBnSW/xy1bD
         Yr6Q==
X-Gm-Message-State: APjAAAVsFcx09BjFKpGqCpsCW6sCqj63FCXkFC5iGO/UBUJ1c2sYjn/g
        HOr6iCO9Z/aAppEgR4yiEUNTF0nbFja3lz8f8EeYKA==
X-Google-Smtp-Source: APXvYqwpsLl/lBCxQvE6ocORN3u54tmPM5QzDZQVLpsXne2Wyc1clqsUC1R97vApkyciht8n3yq4v5JnhU5/vr2tnw0=
X-Received: by 2002:ac8:5557:: with SMTP id o23mr23797687qtr.378.1574112657247;
 Mon, 18 Nov 2019 13:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20191115225557.61847-1-khazhy@google.com> <20191118000214-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191118000214-mutt-send-email-mst@kernel.org>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Mon, 18 Nov 2019 13:30:45 -0800
Message-ID: <CACGdZYJoHSN3vkj_QBz6Txmec9mJMmkH66j2XtqzpUWpfpw4Tg@mail.gmail.com>
Subject: Re: [PATCH] virtio_balloon: fix shrinker pages_to_free calculation
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, wei.w.wang@intel.com,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e4f56e0597a5a9a9"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e4f56e0597a5a9a9
Content-Type: text/plain; charset="UTF-8"

On Sun, Nov 17, 2019 at 9:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Question is, does all this cause any bugs?
>
> I'm not against cleaning this up, not at all, but we need to know the
> impact.
>
> On Fri, Nov 15, 2019 at 02:55:57PM -0800, Khazhismel Kumykov wrote:
> > To my reading, we're accumulating total freed pages in pages_freed, but
> > subtracting it every iteration from pages_to_free, meaning we'll count
> > earlier iterations multiple times, freeing fewer pages than expected.
> > Just accumulate in pages_freed, and compare to pages_to_free.
>
> For nr to scan: yes we scan less objects but that can only happen
> if the first pass does not free enough. And 1st pass can pass
> 256 entries, and my reading of code in do_shrink_slab
> is that it passes only as much as
> #define SHRINK_BATCH 128
>
> so it looks like this never triggers in practice - right?
>

As far as I could tell, there wasn't any significant real impact. It
just raised an eyebrow as I was skimming over it.

SHRINK_BATCH is 128, it does look like we can override the batch size
per shrinker if we desire, but we don't so it's 128, yeah.

>
> >
> > There's also a unit mismatch,
>
> So two unrelated issues, I think we want two patches.
>
>
> > where pages_to_free seems to be virtio
> > balloon pages, and pages_freed is system pages (We divide by
> > VIRTIO_BALLOON_PAGES_PER_PAGE), so sutracting pages_freed from
> > pages_to_free may result in freeing too much.
>
> I am inclining to say we should pass in page units.
> Free page reporting is all done in units of MAX_ORDER - 1.
> Let's not ptopagate the crazy virtio page thing - we hopefully
> will add a saner interface to regular balloon too.
>
> something like the below?
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 226fbb995fb0..128440826b55 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -783,8 +783,8 @@ static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
>          * multiple times to deflate pages till reaching pages_to_free.
>          */
>         while (vb->num_pages && pages_to_free) {
> -               pages_freed += leak_balloon(vb, pages_to_free) /
> -                                       VIRTIO_BALLOON_PAGES_PER_PAGE;
> +               pages_freed += leak_balloon(vb, pages_to_free *
> +                                           VIRTIO_BALLOON_PAGES_PER_PAGE);
>                 pages_to_free -= pages_freed;
>         }
>         update_balloon_size(vb);
> @@ -799,7 +799,7 @@ static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
>         struct virtio_balloon *vb = container_of(shrinker,
>                                         struct virtio_balloon, shrinker);
>
> -       pages_to_free = sc->nr_to_scan * VIRTIO_BALLOON_PAGES_PER_PAGE;
> +       pages_to_free = sc->nr_to_scan;
>
>         if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>                 pages_freed = shrink_free_pages(vb, pages_to_free);
>

leak_balloon returns virtio pages so this would need to actually be
something like pages_freed += leak_balloon(vb, pages_to_free *
PAGES_PER_PAGE) / PAGES_PER_PAGE;, which didn't particularly sit well
with me :)

since leak_balloon is used elsewhere and seems to use "virtio pages" I
opted to have shrink_balloon accept number of "virtio pages", for
consistency.

>
> > There also seems to be a mismatch between shrink_free_pages() and
> > shrink_balloon_pages(), where in both pages_to_free is given as # of
> > virtio pages to free, but free_pages() returns virtio pages, and
> > balloon_pages returns system pages.
> >
> > (For 4K PAGE_SIZE, this mismatch wouldn't be noticed since
> > VIRTIO_BALLOON_PAGES_PER_PAGE would be 1)
>
> About return value:
> The only
> use for count_objects I see is:
>       freeable = shrinker->count_objects(shrinker, shrinkctl);
>       if (freeable == 0 || freeable == SHRINK_EMPTY)
>                 return freeable;
>
> so units do not matter here.
>
>
> For scan objects, IIUC they are eventually propagated to
> shrink_slab. That in turn is called at two sites.
> One ignores the returned value. The other does:
>
>
>         do {
>                 struct mem_cgroup *memcg = NULL;
>
>                 freed = 0;
>                 memcg = mem_cgroup_iter(NULL, NULL, NULL);
>                 do {
>                         freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
>                 } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
>         } while (freed > 10);
>
> so returning a larger than real value because of
> double accounting will just make more calls to the scan
> function.
>
>
>
>
> > Have both return virtio pages, and divide into system pages when
> > returning from shrinker_scan()
> >
> > Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> > Cc: Wei Wang <wei.w.wang@intel.com>
> > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > ---
> >
> > Tested this under memory pressure conditions and the shrinker seemed to
> > shrink.
>
> And to clarify, did you manage to detect it malfunctioning without the
> patch?
>
nope, just a cleanup.

I'll re-send my patches split up, but it sounds like there's some more
incoming as well? I'll leave that to Wei.

khazhy

--000000000000e4f56e0597a5a9a9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS5wYJKoZIhvcNAQcCoIIS2DCCEtQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBNMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWltZWNhMS5j
cnQwHQYDVR0OBBYEFJ2Vb0jiXUWlD5ibz23a558NzWOgMB8GA1UdIwQYMBaAFMs4ErDHmcB4koyz
IZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8v
d3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQCk2Fht/QkHdD9YQlQ/
/BoVlZzl+wg2oB8mPQEGNN49NfSL/ERAGoituF3/Zv+xv6owWk2Xp+sTA69OuAt2wZ4O0pXm2NNb
yE0QS1h/jH61IgJY4dU65qPcUYmkEdBDRX3XzR1wmnDc3yelHxlYerMuJFmSM5g4dIjbdpOlHTGh
jnWrjPPoGaT9nEbPfTxkahJTybnCIMuQbt8nl2QdV64GhBMCQWbIW1xY6Uv0FZcadQhF1vzhd/OH
qGkK98y1Dz/54GBO4A8jOSeDFuh+l2iygTcH16xKfB0XvhoUGdrru24FTEY7p4VTKkw+eJbUvdod
PlESVftk7+JISQWxBEYKMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIMROfpbOE2
LmBNcT9PMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAVUHNimTP93VH0+5bmnf7n
QFH9IOpzzhVwX5BY1EPz1jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xOTExMTgyMTMwNTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAu6/EM3HckLBzGR8MTe2hrSe/VVPFNp4OQDzoXy2U
fbl0XgP9xfUFi3NBC6fb/fzD3G+E0ZF9wEEp08XYXqf7BtUdJVlr86DlPdnR0vYt1+Klq+96/m4a
eCDgiYCTHTlVq0uto0kbbjmf5hYazMhWU+5N6/rtDy7ERietp9nHGiOSHuqvf4H9t+CYdHfovBbX
T2qCOQHHO9q2DxJt6Auu27R5uUhW2IKOIt3GE796C1n9o82RKuaIRv7uFOY7g+BBfmh/5R2q6puV
180I8WPxkhFhrLkHtfVWKwP5XRWXyiqUGt7wBAki7dOuTuAhaLrw4qEFEyygKPO1VKpgJrBACg==
--000000000000e4f56e0597a5a9a9--
