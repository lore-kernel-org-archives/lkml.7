Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7506C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 05:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A8D20838
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 05:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzNpBmwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfGGFai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 01:30:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44973 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGGFai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 01:30:38 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so27634599iob.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FZM543o+sOF0b0l5ODlluNuc0uIsvZfIPtaA0FveIQ=;
        b=VzNpBmwGZekqEydhDbucQs/yKxEkT9AC03JhkfItJhX30+Mb72Z5VyGA/qRGpewUpz
         Ga/wy4qX6BWlLbTh4PUmOCiR1qAImNt7XAcLIFhEzj2XUp6YrVqf5mQN6eagTnUKUHcL
         j3vH39EK4JL6XvRRqGf465dw8JHT4yzjb5PGRhufMQCAQDeH6NihiHZOseBjLe2kz8IN
         XApof0izQK2WXCre6l4wybzZlQ++Mgj82kUEfcnCAiC80QlW04ZLSrBiKgqsRUK89VRE
         IMVgvQ3jXoQoevG8NC+RmZhNSgRAcutmyCSmxPX4uac/7S6M6R25KVRt6JmG+bzOsk5G
         56/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FZM543o+sOF0b0l5ODlluNuc0uIsvZfIPtaA0FveIQ=;
        b=o4FYHTVuu2QLit8mK4jX2Du224dh+SeXIFSpeqBWccN7zw1ijfKJIxiKKoVQgxEn3a
         E9UbSkunL56+Q8KeFNfBG7RDfVvMvP28trGuXE5oO+Ut90RZ+SX4DfQHwMSuwP6JVWxM
         YI3QAwAoxZdSCUZAMRS7+Taqqd5sddV1SAy6YVhFfg/N8ZvYN0wJf4OBM3c/OA90Qu70
         cd0oHsYa/LufUzgMubD+0NAb9Wl7sIhiuT9X+4gd1nmDVpCh2bcl4AMYN9M+hDBlcGXm
         zcbNFk5WTEnNXSX/vfAJS4f3e8J3W/6HFw39r9Htk0e6/KG9k9ObI7AudN8xmfOC4zcg
         E7XA==
X-Gm-Message-State: APjAAAXSCmW+0c2CmpKOZeVNM4/qNiZ2L0gZL5iFP2F5vf4T+mKfkhFe
        36Nzu080qzO4ffCDQM+dTn+DQVFkwjOkSaO0VTs=
X-Google-Smtp-Source: APXvYqxlbrLuLj0h9mXVgzn+NdzTpHCgQkipQo4TreUYGq5s1xgJWPeNRgL/aRUN/5NG5G/m86RGUeAsj/6vWtLRUHQ=
X-Received: by 2002:a02:b10b:: with SMTP id r11mr13011872jah.140.1562477437186;
 Sat, 06 Jul 2019 22:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190702141903.1131-1-kraxel@redhat.com> <20190702141903.1131-7-kraxel@redhat.com>
 <CAPaKu7RfLoB=K__wQd92=S20Mt0uqsfyU9oigr8CQ-=gH6OUuA@mail.gmail.com>
 <20190704111043.5ubc2yjrjphj2iec@sirius.home.kraxel.org> <CAPaKu7S4Og7kda2ZjFtuRv=_W8gpFbD5y7s==0JB5Z34S4Hsjw@mail.gmail.com>
 <20190705085325.am2reucblvxc6qpg@sirius.home.kraxel.org>
In-Reply-To: <20190705085325.am2reucblvxc6qpg@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Sat, 6 Jul 2019 22:30:25 -0700
Message-ID: <CAPaKu7Q1_2-_HNr8Fkh7K61UGUfuAdPHWckH5g4fWt9s2YWiRA@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] drm/virtio: remove ttm calls from in virtio_gpu_object_{reserve,unreserve}
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000009d22d3058d10a0cb"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009d22d3058d10a0cb
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 5, 2019 at 1:53 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Jul 04, 2019 at 12:17:48PM -0700, Chia-I Wu wrote:
> > On Thu, Jul 4, 2019 at 4:10 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > >   Hi,
> > >
> > > > > -       r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> > > > > +       r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
> > > > Can you elaborate a bit about how TTM keeps the BOs alive in, for
> > > > example, virtio_gpu_transfer_from_host_ioctl?  In that function, only
> > > > three TTM functions are called: ttm_bo_reserve, ttm_bo_validate, and
> > > > ttm_bo_unreserve.  I am curious how they keep the BO alive.
> > >
> > > It can't go away between reserve and unreserve, and I think it also
> > > can't be evicted then.  Havn't checked how ttm implements that.
> > Hm, but the vbuf using the BO outlives the reserve/unreserve section.
> > The NO_EVICT flag applies only when the BO is still alive.  Someone
> > needs to hold a reference to the BO to keep it alive, otherwise the BO
> > can go away before the vbuf is retired.
>
> Note that patches 14+15 rework virtio_gpu_transfer_*_ioctl to keep
> gem reference until the command is finished and patch 17 drops
> virtio_gpu_object_{reserve,unreserve} altogether.
>
> Maybe I should try to reorder the series, then squash 6+17 to reduce
> confusion.  I suspect that'll cause quite a few conflicts though ...
This may be well-known and is what you meant by "the fence keeps the
bo alive", but I finally realize that ttm_bo_put delays the deletion
of a BO when it is busy.

In the current design, vbuf does not hold references to its BOs.  Nor
do fences.  It is possible for a BO to lose all its references and
gets virtio_gpu_gem_free_object()ed  while it is still busy.  The key
is ttm_bo_put.

ttm_bo_put calls ttm_bo_cleanup_refs_or_queue to decide whether to
delete the BO immediately (when the BO is already idle) or to queue
the BO to a delayed delete list (when the BO is still busy).  If a BO
is queued to the delayed delete list, ttm_bo_delayed_delete is called
every 10ms (HZ/100 to be exact) to scan through the list and delete
idled BOs.

I wrote a simple test (attached) and added a bunch of printk's to confirm this.

Anyway, I believe the culprit is patch 11, when we switch from
ttm_bo_put to drm_gem_shmem_free_object to free a BO whose last
reference is gone.  The deletion becomes immediately after the switch.
We need to fix vbuf to refcount its BOs before we can do the switch.


>
> cheers,
>   Gerd
>

--0000000000009d22d3058d10a0cb
Content-Type: text/x-c-code; charset="US-ASCII"; name="virtio-gpu-bo.c"
Content-Disposition: attachment; filename="virtio-gpu-bo.c"
Content-Transfer-Encoding: base64
Content-ID: <f_jxshstmh0>
X-Attachment-Id: f_jxshstmh0

LyogZ2NjIC1zdGQ9YzExIC1EX0dOVV9TT1VSQ0UgLW8gdmlydGlvLWdwdS1ibyB2aXJ0aW8tZ3B1
LWJvLmMgKi8KCiNpbmNsdWRlIDxhc3NlcnQuaD4KI2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVk
ZSA8c3RkaW8uaD4KCiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8bGliZHJtL2RybS5oPgoj
aW5jbHVkZSA8c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgojaW5jbHVkZSA8c3lz
L3R5cGVzLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNkZWZpbmUgUElQRV9CVUZGRVIgMAojZGVm
aW5lIFZJUkdMX0ZPUk1BVF9SOF9VTk9STSA2NAojZGVmaW5lIFZJUkdMX0JJTkRfQ09OU1RBTlRf
QlVGRkVSICgxIDw8IDYpCiNkZWZpbmUgRFJNX1ZJUlRHUFVfUkVTT1VSQ0VfQ1JFQVRFIDB4MDQK
I2RlZmluZSBEUk1fSU9DVExfVklSVEdQVV9SRVNPVVJDRV9DUkVBVEUgXAogICAgRFJNX0lPV1Io
RFJNX0NPTU1BTkRfQkFTRSArIERSTV9WSVJUR1BVX1JFU09VUkNFX0NSRUFURSwgXAogICAgICAg
ICAgICBzdHJ1Y3QgZHJtX3ZpcnRncHVfcmVzb3VyY2VfY3JlYXRlKQpzdHJ1Y3QgZHJtX3ZpcnRn
cHVfcmVzb3VyY2VfY3JlYXRlIHsKICAgIHVpbnQzMl90IHRhcmdldDsKICAgIHVpbnQzMl90IGZv
cm1hdDsKICAgIHVpbnQzMl90IGJpbmQ7CiAgICB1aW50MzJfdCB3aWR0aDsKICAgIHVpbnQzMl90
IGhlaWdodDsKICAgIHVpbnQzMl90IGRlcHRoOwogICAgdWludDMyX3QgYXJyYXlfc2l6ZTsKICAg
IHVpbnQzMl90IGxhc3RfbGV2ZWw7CiAgICB1aW50MzJfdCBucl9zYW1wbGVzOwogICAgdWludDMy
X3QgZmxhZ3M7CiAgICB1aW50MzJfdCBib19oYW5kbGU7CiAgICB1aW50MzJfdCByZXNfaGFuZGxl
OwogICAgdWludDMyX3Qgc2l6ZTsKICAgIHVpbnQzMl90IHN0cmlkZTsKfTsKCnN0cnVjdCBkcm1f
dmlydGdwdV8zZF9ib3ggeyAKICAgIHVpbnQzMl90IHgsIHksIHo7CiAgICB1aW50MzJfdCB3LCBo
LCBkOwp9OwoKI2RlZmluZSBEUk1fVklSVEdQVV9UUkFOU0ZFUl9UT19IT1NUIDB4MDcKI2RlZmlu
ZSBEUk1fSU9DVExfVklSVEdQVV9UUkFOU0ZFUl9UT19IT1NUIFwKICAgIERSTV9JT1dSKERSTV9D
T01NQU5EX0JBU0UgKyBEUk1fVklSVEdQVV9UUkFOU0ZFUl9UT19IT1NULCBcCiAgICAgICAgICAg
IHN0cnVjdCBkcm1fdmlydGdwdV8zZF90cmFuc2Zlcl90b19ob3N0KQpzdHJ1Y3QgZHJtX3ZpcnRn
cHVfM2RfdHJhbnNmZXJfdG9faG9zdCB7CiAgICB1aW50MzJfdCBib19oYW5kbGU7CiAgICBzdHJ1
Y3QgZHJtX3ZpcnRncHVfM2RfYm94IGJveDsKICAgIHVpbnQzMl90IGxldmVsOwogICAgdWludDMy
X3Qgb2Zmc2V0OyAKfTsgCgpzdGF0aWMgdWludDMyX3QgYnVmZmVyX2NyZWF0ZShpbnQgZmQsIHVp
bnQzMl90IHNpemUpCnsKICAgIHN0cnVjdCBkcm1fdmlydGdwdV9yZXNvdXJjZV9jcmVhdGUgYXJn
cyA9IHsKICAgICAgICAudGFyZ2V0ID0gUElQRV9CVUZGRVIsCiAgICAgICAgLmZvcm1hdCA9IFZJ
UkdMX0ZPUk1BVF9SOF9VTk9STSwKICAgICAgICAuYmluZCA9IFZJUkdMX0JJTkRfQ09OU1RBTlRf
QlVGRkVSLAogICAgICAgIC53aWR0aCA9IHNpemUsCiAgICAgICAgLmhlaWdodCA9IDEsCiAgICAg
ICAgLmRlcHRoID0gMSwKICAgICAgICAuYXJyYXlfc2l6ZSA9IDEsCiAgICAgICAgLm5yX3NhbXBs
ZXMgPSAxLAogICAgfTsKICAgIGludCByZXQgPSBpb2N0bChmZCwgRFJNX0lPQ1RMX1ZJUlRHUFVf
UkVTT1VSQ0VfQ1JFQVRFLCAmYXJncyk7CiAgICBhc3NlcnQoIXJldCk7CiAgICByZXR1cm4gYXJn
cy5ib19oYW5kbGU7Cn0KCnN0YXRpYyB2b2lkIGJ1ZmZlcl9jbG9zZShpbnQgZmQsIHVpbnQzMl90
IGJvKQp7CiAgICBzdHJ1Y3QgZHJtX2dlbV9jbG9zZSBhcmdzID0gewogICAgICAgIC5oYW5kbGUg
PSBibywKICAgIH07CiAgICBpbnQgcmV0ID0gaW9jdGwoZmQsIERSTV9JT0NUTF9HRU1fQ0xPU0Us
ICZhcmdzKTsKICAgIGFzc2VydCghcmV0KTsKfQpzdGF0aWMgdm9pZCB0cmFuc2Zlcl90b19ob3N0
KGludCBmZCwgdWludDMyX3QgYm8sIHVpbnQzMl90IHNpemUpCnsKICAgIHN0cnVjdCBkcm1fdmly
dGdwdV8zZF90cmFuc2Zlcl90b19ob3N0IGFyZ3MgPSB7CiAgICAgICAgLmJvX2hhbmRsZSA9IGJv
LAogICAgICAgIC5ib3gudyA9IHNpemUsCiAgICAgICAgLmJveC5oID0gMSwKICAgICAgICAuYm94
LmQgPSAxLAogICAgfTsKICAgIGludCByZXQgPSBpb2N0bChmZCwgRFJNX0lPQ1RMX1ZJUlRHUFVf
VFJBTlNGRVJfVE9fSE9TVCwgJmFyZ3MpOwogICAgYXNzZXJ0KCFyZXQpOwp9CgppbnQgbWFpbigp
CnsKICAgIGNvbnN0IHVpbnQzMl90IHNpemUgPSAxICogMTAyNCAqIDEwMjQ7CgogICAgaW50IGZk
ID0gb3BlbigiL2Rldi9kcmkvcmVuZGVyRDEyOCIsIE9fUkRXUik7CiAgICBhc3NlcnQoZmQgPj0g
MCk7CgogICAgdWludDMyX3QgYm8gPSBidWZmZXJfY3JlYXRlKGZkLCBzaXplKTsKICAgIHByaW50
ZigidHJhbnNmZXIgYW5kIGNsb3NlIHRoZSBCTyBpbW1lZGlhdGVseS4uLlxuIik7CiAgICB0cmFu
c2Zlcl90b19ob3N0KGZkLCBibywgc2l6ZSk7CiAgICBidWZmZXJfY2xvc2UoZmQsIGJvKTsKCiAg
ICBwcmludGYoIndhaXQgZm9yIDEgc2Vjb25kLi4uXG4iKTsKICAgIHVzbGVlcCgxMDAwICogMTAw
MCk7CgogICAgY2xvc2UoZmQpOwoKICAgIHJldHVybiAwOwp9Cg==
--0000000000009d22d3058d10a0cb--
