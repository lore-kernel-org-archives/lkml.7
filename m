Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8853FC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BE221019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="SlDVAnVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfGKIXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:23:14 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:14050 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfGKIXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:23:13 -0400
Date:   Thu, 11 Jul 2019 08:23:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1562833387;
        bh=OgHruR/8hfMeDLBEYOwTfEFvnoOfeQ+NrS6TSnWjCWk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=SlDVAnVKjXvtCtdhhuGUULsRsWC7yAqQBVTnYK7yRVQc2vMteYxJVBeWVGzSS16l2
         +p9wz52SNGKHSNlFHO8AZezeqp7jHI1IHE5w0V4mvby2GFqz/j1b8UG4ZqUsbOjNy6
         a80rBN+Hy//KJ1kRcs1jPm45NC5xqkUhcJuQoaLM=
To:     Daniel Vetter <daniel@ffwll.ch>
From:   Simon Ser <contact@emersion.fr>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH V3 3/5] drm/vkms: Decouple crc operations from composer
Message-ID: <3btolF-iC_bUcyzo-zi59zM7NaH48sTEQkbB-TAKZJOsm8DkUq4LhpApi6Mep0npPQ-slnIzxQfoatEXDVQi-H6Ypv-zwcctRvimXF0TZAo=@emersion.fr>
In-Reply-To: <20190711081913.GH15868@phenom.ffwll.local>
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <6e8a03dc7c666ee998ee36172a96cff39f8dd46d.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <20190711081913.GH15868@phenom.ffwll.local>
Feedback-ID: FsVprHBOgyvh0T8bxcZ0CmvJCosWkwVUg658e_lOUQMnA9qynD8O1lGeniuBDfPSkDAUuhiKfOIXUZBfarMyvA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 11, 2019 11:19 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> Aside: This all kinda doesn't go in the right direction for
> high-performance composing, so I guess I need to get started with typing
> up what that should look like.

Some related logs from IRC:

2019-07-10 19:42:49     danvet  ickle, is there an idiot guide to reasonabl=
e fast blending/composing with the cpu?
2019-07-10 19:43:13     danvet  for vkms, so maitainability is high on the =
wishlist, but it needs to be somewhat fast to be able to keep up
2019-07-10 19:44:02     ickle   pixman for rectangles
2019-07-10 19:45:00     ickle   if you want reasonably fast, you want simd
2019-07-10 19:45:16     ickle   so better to use some prebaked library
2019-07-10 19:45:38     ickle   but within vkms?
2019-07-10 19:45:48     ickle   or just for igt/vkms?
2019-07-10 19:46:40     ickle   within vkms for writeback blending I guess
2019-07-10 19:51:38     ickle   http://paste.debian.net/1091097/
2019-07-10 19:53:08     ickle   http://paste.debian.net/1091098/
2019-07-10 19:54:36     emersion        danvet: what are your plans for the=
 compositor refactoring?
2019-07-10 19:55:21     emersion        are we still really using macros in=
stead of functions
2019-07-10 19:56:22     <--     nvishwa1 (~nvishwa1@192.55.54.44) has quit =
(Remote host closed the connection)
2019-07-10 19:56:44     emersion        is this coming from pixman, ickle?
2019-07-10 19:56:50     -->     karolherbst (~kherbst@2a02:8308:b0be:6900:d=
9e8:6dcd:2f6a:6cb5) has joined #intel-gfx
2019-07-10 19:57:23     ickle   yes, take it as a reference on how to do ab=
gr32 premultiplied alpha blending
2019-07-10 19:57:33     <--     amathes (ajmathes@nat/intel/x-ywywuftprrqnd=
baj) has quit (Ping timeout: 245 seconds)
2019-07-10 19:57:48     emersion        yeah, that's a good idea
2019-07-10 19:57:49     ickle   or argb32 actually
2019-07-10 19:58:01     emersion        (asking for the source because lice=
nse)
2019-07-10 19:58:04     ickle   MIT
2019-07-10 19:58:07     emersion        nice
2019-07-10 20:00:12     <--     sandeep (sandeep@nat/intel/x-buwbzkgopszvwb=
cr) has quit (Remote host closed the connection)
2019-07-10 20:01:34     danvet  ickle, yeah vkms in the kernel
2019-07-10 20:02:41     danvet  also might need more than 8 bits ...
2019-07-10 20:02:57     danvet  and kinda hoped I could just tell gcc to si=
mdify it for me
2019-07-10 20:03:23     danvet  emersion, compositor refactoring
2019-07-10 20:03:46     danvet  ickle, higher level I figured something lik=
e a fetch fifo in a standard format
2019-07-10 20:04:02     danvet  with some drm_format->standard format conve=
rsion tools
2019-07-10 20:04:08     danvet  and then one blender
2019-07-10 20:04:39     danvet  and then either add that to the crc and tos=
s it (again maybe scanline-by-scanline, or whatever fits reasonable into l1=
$ all together)
2019-07-10 20:04:44     danvet  or dump it into writeback
2019-07-10 20:08:25     danvet  https://gcc.gnu.org/onlinedocs/gcc/Vector-E=
xtensions.html <- this stuff essentially, using generics
2019-07-10 20:08:38     danvet  *generic intrinsics
2019-07-10 20:08:49     danvet  or is that going to be real awful?
2019-07-10 20:09:35     ickle   shouldn't be required for _basic_ blending
2019-07-10 20:09:52     danvet  yeah I think all we want is premultiplied a=
lpha
2019-07-10 20:09:53     ickle   if all you need is an over operator, then g=
cc should be pretty good
2019-07-10 20:09:57     <--     sdutt (sdutt@nat/intel/x-zhquyrigdztslyqh) =
has quit (Ping timeout: 268 seconds)
2019-07-10 20:09:59     danvet  maybe some yuv->rgb
2019-07-10 20:10:19     danvet  expanding from whatever silly format we hav=
e to the right vector
2019-07-10 20:10:33     emersion        what would be your universal format=
?
2019-07-10 20:10:46     danvet  a16r16b16g16
2019-07-10 20:10:50     danvet  except if gcc barfs on that
2019-07-10 20:11:02     danvet  or maybe go all in on 4x float :-)
2019-07-10 20:11:10     emersion        eh
2019-07-10 20:11:29     emersion        fp16 would work, but would also mea=
n rounding errors, probably?
2019-07-10 20:11:35     danvet  uint16 is not going to be awesome for hdr, =
but good enough for everything else
2019-07-10 20:11:42     danvet  no cpu has fp16
2019-07-10 20:11:52     emersion        ah, fp32
2019-07-10 20:11:57     krh     wait for avx1024
2019-07-10 20:12:01     emersion        seems kind of overkill
2019-07-10 20:12:01     danvet  fg32 is probably fastest option we can get =
on common hw
2019-07-10 20:12:12     danvet  krh, very much aiming for good enough here
2019-07-10 20:12:26     ickle   one plan is to sneak ksim into the kernel a=
s generic gpu-on-x86
2019-07-10 20:12:52     krh     can the kernel use avx2?
2019-07-10 20:13:05     danvet  well, all stuff I'd need to figure out
2019-07-10 20:13:07     danvet  I hope so
2019-07-10 20:13:12     ickle   it can
2019-07-10 20:13:19     ickle   easier than mmx
2019-07-10 20:13:49     emersion        when you say gcc barfs on a16r16b16=
g16: why?
2019-07-10 20:13:57     danvet  kernel_fpu_begin/end + telling gcc to optim=
ize the crap out of the file with the blending functions
2019-07-10 20:14:11     emersion        uint64 too hard for gcc to optimize=
?
2019-07-10 20:14:14     danvet  emersion, I haven't checked, but if it gene=
rates silly code then might be better to go with fp32
2019-07-10 20:14:28     vsyrjala        the compiler always generates silly=
 code
2019-07-10 20:14:30     danvet  ideally it should all boil down to sse/avx
2019-07-10 20:14:32     emersion        ahah
2019-07-10 20:14:51     danvet  and ideally all with generic intrinsics so =
the arm folks don't freak out
2019-07-10 20:15:07     -->     sandeep (~sandeep@134.134.139.76) has joine=
d #intel-gfx
2019-07-10 20:15:23     emersion        +1 for generic intrinsics
2019-07-10 20:15:42     danvet  the conversion from uint to fp32 might be h=
ilarious
2019-07-10 20:15:50     emersion        yeah, probably
2019-07-10 20:15:52     danvet  perhaps the one place where we want to use =
an sse or avx intrinsic
2019-07-10 20:16:19     danvet  especially if we convert to simd16 instead =
of something like 4x4
2019-07-10 20:16:22     emersion        we should probably do some little e=
xperiments before doing anything
2019-07-10 20:16:24     danvet  simd4x4
2019-07-10 20:16:31     danvet  yeah
2019-07-10 20:16:41     danvet  that's why I'm asking here, since I have ro=
ughly 0 clue about this
2019-07-10 20:17:48     danvet  I don't think we ever need a dot or anythin=
g like that, so plain simd is propably best
2019-07-10 20:18:07     danvet  except the input is usually 4x or 3x vector=
s
2019-07-10 20:18:07     emersion        a dot?
2019-07-10 20:18:12     danvet  dot product
2019-07-10 20:18:14     emersion        ah
2019-07-10 20:18:15     danvet  for vertex shaders
2019-07-10 20:18:20     emersion        yeah, probably not
2019-07-10 20:18:21     bwidawsk        danvet=E2=80=BA btw, I think "gener=
ic intrinsic" is an ARM thing
2019-07-10 20:18:29     bwidawsk        I think everywhere else, they just =
say intrinsic
2019-07-10 20:18:41     bwidawsk        at least, I've never heard the gene=
ric prefix other than ARM compiler
2019-07-10 20:19:19     vsyrjala        just make the max supported resolut=
ion 8x8 or something and speed shouldn't be a huge issue
2019-07-10 20:19:30     emersion        i think he meant generic intrinsic =
vs. sse/avx/whatever
2019-07-10 20:19:49     bwidawsk        emersion=E2=80=BA yes, I figured ou=
t what he meant, I just mentioned it because it was a source of confusion
2019-07-10 20:19:52     emersion        vsyrjala, helpful as always :)
2019-07-10 20:20:32     danvet  oh gcc has all the casting implementing in =
the intrinsics too
2019-07-10 20:20:50     danvet  bwidawsk, gcc manpage also calls them gener=
ic intrinsics
2019-07-10 20:21:25     bwidawsk        danvet=E2=80=BA not my gcc manpage
2019-07-10 20:21:40     danvet  well "generic vector operations"
2019-07-10 20:21:46     danvet  ^^ that what you meant?
2019-07-10 20:22:03     danvet  vs "machine-specific vector intrinsics"
2019-07-10 20:22:38     bwidawsk        I thought the generic intrinsic ter=
m came from ARM's proprietary compiler
2019-07-10 20:22:40     bwidawsk        but I might be wrong

