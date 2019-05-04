Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384CDC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD32F2053B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni6NrGd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfEDOrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 10:47:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33563 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEDOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 10:47:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so6953791qtf.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tHvp23vAOHnqP3XLqEa7riti1VVwN0uGbECBOBFk2E=;
        b=Ni6NrGd2qbZPy6+OUx9heT2B3EZaSFCQIJbPn+4Yjj7oPGO0VjIhU9Kor6v3M5KStn
         xc+BQtXHbddEtP7o4QJKNn/+EuxI0+9k24ticsupVE1y6+sH1IdCGbsqn4Ss/WPCs1nR
         SGTNpC2z3/hPsBnliLlWGNzd0ziKnUnHluEjqUMf8hba7ooEQTdX+eZjOmPNe3BtREco
         2yxuzeck6ArUwEbplLJzz8WQG0lTInM0cnn/dpG4WhYpatzAbkyesWuJH1TQONwrT92S
         THm93rXHsOcJkzM6rwqYDHEyCWOePiwWQD32GsNpOlXfX0ylOQBnTzF5It2IotFzyQBQ
         FE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tHvp23vAOHnqP3XLqEa7riti1VVwN0uGbECBOBFk2E=;
        b=i85nM3mR6/+F4N+sSsOnLBVXOOTKTgsoJop1ADQ5Xfjc3P2N/N3XyMW/CjV81H5l42
         2bsH6+25fqC0KlRA75cmn4FUNQeOgmwlaZyN7M66rkznjEGL+VJXwpP80ja2SORrGjV0
         RNOOdFFegtyDkSDsxm3tgasKWdlVoR0MK3kJVZ8tE/s/uyrPpCrw1L4ySBK4fR98lVjP
         pFCjRZPh6cN/p37918y0Wxqw017DEpadfNiRetgySGH1RaOdFbCq072QDBPONF+a0wPr
         TvogcJ/Dbiipdx3plDjDB5a9rUPzhTadrutvGOYcdxOlJWb68L0Nw/1oH+CmRbdwLf0t
         4WcA==
X-Gm-Message-State: APjAAAUT9FH614oNyNm+OSfqTDdqj5I7VEtjEukWRYethLWtYUE3ilfm
        XBtB4qJ1I+s7El1oNYJmePguDd7MvHrf7DIKD1Q=
X-Google-Smtp-Source: APXvYqwPcPReutQ2MpPR0lFP0RN4OzrdhnEsPdbe8FaLnXB52eg3uamsAPiZs8lqtaODVyvojLlY7zxn3SlAaTr/wwA=
X-Received: by 2002:a0c:afd4:: with SMTP id t20mr13573017qvc.128.1556981238664;
 Sat, 04 May 2019 07:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190423143258.96706-1-smuchun@gmail.com> <24b0fff3775147c04b006282727d94fea7f408b4.camel@kernel.crashing.org>
 <CAPSr9jHhwASv7=83hU+81mC0JJyuyt2gGxLmyzpCOfmc9vKgGQ@mail.gmail.com>
 <a37e7a49c3e7fa6ece2be2b76798fef3e51ade4e.camel@kernel.crashing.org>
 <CAPSr9jHCVCHNK+AmKkUBgs4dPC0UC5KdYKqMinkauyL3OL6qrQ@mail.gmail.com> <79fbc203bc9fa09d88ab2c4bff8635be4c293d49.camel@kernel.crashing.org>
In-Reply-To: <79fbc203bc9fa09d88ab2c4bff8635be4c293d49.camel@kernel.crashing.org>
From:   Muchun Song <smuchun@gmail.com>
Date:   Sat, 4 May 2019 22:47:07 +0800
Message-ID: <CAPSr9jHw9hgAZo2TuDAKdSLEG1c6EtJG005MWxsxfnbsk1AXow@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix use-after-free and double free on glue directory
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhaowuyun@wingtech.com
Content-Type: multipart/mixed; boundary="000000000000a7321e058810f18b"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a7321e058810f18b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Benjamin Herrenschmidt <benh@kernel.crashing.org> =E4=BA=8E2019=E5=B9=B45=
=E6=9C=882=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=882:25=E5=86=99=E9=81=
=93=EF=BC=9A

> > > The basic idea yes, the whole bool *locked is horrid though.
> > > Wouldn't it
> > > work to have a get_device_parent_locked that always returns with
> > > the mutex held,
> > > or just move the mutex to the caller or something simpler like this
> > > ?
> > >
> >
> > Greg and Rafael, do you have any suggestions for this? Or you also
> > agree with Ben?
>
> Ping guys ? This is worth fixing...

I also agree with you. But Greg and Rafael seem to be high latency right no=
w.

From your suggestions, I think introduce get_device_parent_locked() may eas=
y
to fix. So, do you agree with the fix of the following code snippet
(You can also
view attachments)?

I introduce a new function named get_device_parent_locked_if_glue_dir() whi=
ch
always returns with the mutex held only when we live in glue dir. We should=
 call
unlock_if_glue_dir() to release the mutex. The
get_device_parent_locked_if_glue_dir()
and unlock_if_glue_dir() should be called in pairs.

---
drivers/base/core.c | 44 ++++++++++++++++++++++++++++++++++++--------
1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4aeaa0c92bda..5112755c43fa 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1739,8 +1739,9 @@ class_dir_create_and_add(struct class *class,
struct kobject *parent_kobj)
static DEFINE_MUTEX(gdp_mutex);
-static struct kobject *get_device_parent(struct device *dev,
-                    struct device *parent)
+static struct kobject *__get_device_parent(struct device *dev,
+                    struct device *parent,
+                    bool lock)
{
   if (dev->class) {
       struct kobject *kobj =3D NULL;
@@ -1779,14 +1780,16 @@ static struct kobject
*get_device_parent(struct device *dev,
           }
       spin_unlock(&dev->class->p->glue_dirs.list_lock);
       if (kobj) {
-           mutex_unlock(&gdp_mutex);
+           if (!lock)
+               mutex_unlock(&gdp_mutex);
           return kobj;
       }
       /* or create a new class-directory at the parent device */
       k =3D class_dir_create_and_add(dev->class, parent_kobj);
       /* do not emit an uevent for this simple "glue" directory */
-       mutex_unlock(&gdp_mutex);
+       if (!lock)
+           mutex_unlock(&gdp_mutex);
       return k;
   }
@@ -1799,6 +1802,19 @@ static struct kobject *get_device_parent(struct
device *dev,
   return NULL;
}
+static inline struct kobject *get_device_parent(struct device *dev,
+                       struct device *parent)
+{
+   return __get_device_parent(dev, parent, false);
+}
+
+static inline struct kobject *
+get_device_parent_locked_if_glue_dir(struct device *dev,
+                struct device *parent)
+{
+   return __get_device_parent(dev, parent, true);
+}
+
static inline bool live_in_glue_dir(struct kobject *kobj,
                struct device *dev)
{
@@ -1831,6 +1847,16 @@ static void cleanup_glue_dir(struct device
*dev, struct kobject *glue_dir)
   mutex_unlock(&gdp_mutex);
}
+static inline void unlock_if_glue_dir(struct device *dev,
+                struct kobject *glue_dir)
+{
+   /* see if we live in a "glue" directory */
+   if (!live_in_glue_dir(glue_dir, dev))
+       return;
+
+   mutex_unlock(&gdp_mutex);
+}
+
static int device_add_class_symlinks(struct device *dev)
{
   struct device_node *of_node =3D dev_of_node(dev);
@@ -2040,7 +2066,7 @@ int device_add(struct device *dev)
   pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
   parent =3D get_device(dev->parent);
-   kobj =3D get_device_parent(dev, parent);
+   kobj =3D get_device_parent_locked_if_glue_dir(dev, parent);
   if (IS_ERR(kobj)) {
       error =3D PTR_ERR(kobj);
       goto parent_error;
@@ -2055,10 +2081,12 @@ int device_add(struct device *dev)
   /* first, register with generic layer. */
   /* we require the name to be set before, and pass NULL */
   error =3D kobject_add(&dev->kobj, dev->kobj.parent, NULL);
-   if (error) {
-       glue_dir =3D get_glue_dir(dev);
+
+   glue_dir =3D get_glue_dir(dev);
+   unlock_if_glue_dir(dev, glue_dir);
+
+   if (error)
       goto Error;
-   }
   /* notify platform of device entry */
   error =3D device_platform_notify(dev, KOBJ_ADD);
--

--000000000000a7321e058810f18b
Content-Type: application/octet-stream; 
	name="0001-driver-core-Fix-use-after-free-and-double-free-on-gl.patch"
Content-Disposition: attachment; 
	filename="0001-driver-core-Fix-use-after-free-and-double-free-on-gl.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jv9m2idk0>
X-Attachment-Id: f_jv9m2idk0

RnJvbSAwOTFhMDgwMDY2NDIwMWMxNzE5YjJhYTFiY2Q5NjVmOTU3OGVlMTNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNdWNodW4gU29uZyA8c211Y2h1bkBnbWFpbC5jb20+CkRhdGU6
IFN1biwgMjggQXByIDIwMTkgMjM6MzE6MDYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBkcml2ZXIg
Y29yZTogRml4IHVzZS1hZnRlci1mcmVlIGFuZCBkb3VibGUgZnJlZSBvbiBnbHVlCiBkaXJlY3Rv
cnkKClRoZXJlIGlzIGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiByZW1vdmluZyBnbHVlIGRpcmVj
dG9yeSBhbmQgYWRkaW5nIGEgbmV3CmRldmljZSB1bmRlciB0aGUgZ2x1ZSBkaXJlY3RvcnkuIEl0
IGNhbiBiZSByZXByb2R1Y2VkIGluIGZvbGxvd2luZyB0ZXN0OgoKcGF0aCAxOiBBZGQgdGhlIGNo
aWxkIGRldmljZSB1bmRlciBnbHVlIGRpcgpkZXZpY2VfYWRkKCkKICAgIGdldF9kZXZpY2VfcGFy
ZW50KCkKICAgICAgICBtdXRleF9sb2NrKCZnZHBfbXV0ZXgpOwogICAgICAgIC4uLi4KICAgICAg
ICAvKmZpbmQgcGFyZW50IGZyb20gZ2x1ZV9kaXJzLmxpc3QqLwogICAgICAgIGxpc3RfZm9yX2Vh
Y2hfZW50cnkoaywgJmRldi0+Y2xhc3MtPnAtPmdsdWVfZGlycy5saXN0LCBlbnRyeSkKICAgICAg
ICAgICAgaWYgKGstPnBhcmVudCA9PSBwYXJlbnRfa29iaikgewogICAgICAgICAgICAgICAga29i
aiA9IGtvYmplY3RfZ2V0KGspOwogICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgIH0K
ICAgICAgICAuLi4uCiAgICAgICAgbXV0ZXhfdW5sb2NrKCZnZHBfbXV0ZXgpOwogICAgICAgIC4u
Li4KICAgIC4uLi4KICAgIGtvYmplY3RfYWRkKCkKICAgICAgICBrb2JqZWN0X2FkZF9pbnRlcm5h
bCgpCiAgICAgICAgICAgIGNyZWF0ZV9kaXIoKQogICAgICAgICAgICAgICAgc3lzZnNfY3JlYXRl
X2Rpcl9ucygpCiAgICAgICAgICAgICAgICAgICAgaWYgKGtvYmotPnBhcmVudCkKICAgICAgICAg
ICAgICAgICAgICAgICAgcGFyZW50ID0ga29iai0+cGFyZW50LT5zZDsKICAgICAgICAgICAgICAg
ICAgICAuLi4uCiAgICAgICAgICAgICAgICAgICAga2VybmZzX2NyZWF0ZV9kaXJfbnMocGFyZW50
KQogICAgICAgICAgICAgICAgICAgICAgICBrZXJuZnNfbmV3X25vZGUoKQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAga2VybmZzX2dldChwYXJlbnQpCiAgICAgICAgICAgICAgICAgICAgICAg
IC4uLi4KICAgICAgICAgICAgICAgICAgICAgICAgLyogbGluayBpbiAqLwogICAgICAgICAgICAg
ICAgICAgICAgICByYyA9IGtlcm5mc19hZGRfb25lKGtuKTsKICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKCFyYykKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBrbjsKCiAgICAg
ICAgICAgICAgICAgICAgICAgIGtlcm5mc19wdXQoa24pCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAuLi4uCiAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXBlYXQ6CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBrbWVtX2NhY2hlX2ZyZWUoa24pCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBrbiA9IHBhcmVudDsKCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoa24p
IHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoYXRvbWljX2RlY19hbmRfdGVz
dCgma24tPmNvdW50KSkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBy
ZXBlYXQ7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAg
ICAgIC4uLi4KCnBhdGgyOiBSZW1vdmUgbGFzdCBjaGlsZCBkZXZpY2UgdW5kZXIgZ2x1ZSBkaXIK
ZGV2aWNlX2RlbCgpCiAgICBjbGVhbnVwX2RldmljZV9wYXJlbnQoKQogICAgICAgIGNsZWFudXBf
Z2x1ZV9kaXIoKQogICAgICAgICAgICBtdXRleF9sb2NrKCZnZHBfbXV0ZXgpOwogICAgICAgICAg
ICBpZiAoIWtvYmplY3RfaGFzX2NoaWxkcmVuKGdsdWVfZGlyKSkKICAgICAgICAgICAgICAgIGtv
YmplY3RfZGVsKGdsdWVfZGlyKTsKICAgICAgICAgICAga29iamVjdF9wdXQoZ2x1ZV9kaXIpOwog
ICAgICAgICAgICBtdXRleF91bmxvY2soJmdkcF9tdXRleCk7CgpCZWZvcmUgcGF0aDIgcmVtb3Zl
IGxhc3QgY2hpbGQgZGV2aWNlIHVuZGVyIGdsdWUgZGlyLCBJZiBwYXRoMSBhZGQgYSBuZXcKZGV2
aWNlIHVuZGVyIGdsdWUgZGlyLCB0aGUgZ2x1ZV9kaXIga29iamVjdCByZWZlcmVuY2UgY291bnQg
d2lsbCBiZQppbmNyZWFzZSB0byAyIHZpYSBrb2JqZWN0X2dldChrKSBpbiBnZXRfZGV2aWNlX3Bh
cmVudCgpLiBBbmQgcGF0aDEgaGFzCmJlZW4gY2FsbGVkIGtlcm5mc19uZXdfbm9kZSgpLCBidXQg
bm90IGNhbGwga2VybmZzX2dldChwYXJlbnQpLgpNZWFud2hpbGUsIHBhdGgyIGNhbGwga29iamVj
dF9kZWwoZ2x1ZV9kaXIpIGJlYWNhdXNlIDAgaXMgcmV0dXJuZWQgYnkKa29iamVjdF9oYXNfY2hp
bGRyZW4oKS4gVGhpcyByZXN1bHQgaW4gZ2x1ZV9kaXItPnNkIGlzIGZyZWVkIGFuZCBpdCdzCnJl
ZmVyZW5jZSBjb3VudCB3aWxsIGJlIDAuIFRoZW4gcGF0aDEgY2FsbCBrZXJuZnNfZ2V0KHBhcmVu
dCkgd2lsbCB0cmlnZ2VyCmEgd2FybmluZyBpbiBrZXJuZnNfZ2V0KCkoV0FSTl9PTighYXRvbWlj
X3JlYWQoJmtuLT5jb3VudCkpKSBhbmQgaW5jcmVhc2UKaXQncyByZWZlcmVuY2UgY291bnQgdG8g
MS4gQmVjYXVzZSBnbHVlX2Rpci0+c2QgaXMgZnJlZWQgYnkgcGF0aDIsIHRoZSBuZXh0CmNhbGwg
a2VybmZzX2FkZF9vbmUoKSBieSBwYXRoMSB3aWxsIGZhaWwoVGhpcyBpcyBhbHNvIHVzZS1hZnRl
ci1mcmVlKQphbmQgY2FsbCBhdG9taWNfZGVjX2FuZF90ZXN0KCkgdG8gZGVjcmVhc2UgcmVmZXJl
bmNlIGNvdW50LiBCZWNhdXNlIHRoZQpyZWZlcmVuY2UgY291bnQgaXMgZGVjcmVtZW50ZWQgdG8g
MCwgaXQgd2lsbCBhbHNvIGNhbGwga21lbV9jYWNoZV9mcmVlKCkKdG8gZnJlZSBnbHVlX2Rpci0+
c2QgYWdhaW4uIFRoaXMgd2lsbCByZXN1bHQgaW4gZG91YmxlIGZyZWUuCgpJbiBvcmRlciB0byBh
dm9pZCB0aGlzIGhhcHBlbmluZywgd2Ugd2Ugc2hvdWxkIG5vdCBjYWxsIGtvYmplY3RfZGVsKCkg
b24KcGF0aDIgd2hlbiB0aGUgcmVmZXJlbmNlIGNvdW50IG9mIGdsdWVfZGlyIGlzIGdyZWF0ZXIg
dGhhbiAxLiBTbyB3ZSBhZGQgYQpjb25kaXRpb25hbCBzdGF0ZW1lbnQgdG8gZml4IGl0LgoKVGhl
IGZvbGxvd2luZyBjYWxsdHJhY2UgaXMgY2FwdHVyZWQgaW4ga2VybmVsIDQuMTQgd2l0aCB0aGUg
Zm9sbG93aW5nIHBhdGNoCmFwcGxpZWQ6Cgpjb21taXQgNzI2ZTQxMDk3OTIwICgiZHJpdmVyczog
Y29yZTogUmVtb3ZlIGdsdWUgZGlycyBmcm9tIHN5c2ZzIGVhcmxpZXIiKQoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KWyAgICAzLjYzMzcwM10gV0FSTklORzogQ1BVOiA0IFBJRDogNTEzIGF0IC4uLi9mcy9r
ZXJuZnMvZGlyLmM6NDk0CiAgICAgICAgICAgICAgICBIZXJlIGlzIFdBUk5fT04oIWF0b21pY19y
ZWFkKCZrbi0+Y291bnQpIGluIGtlcm5mc19nZXQoKS4KLi4uLgpbICAgIDMuNjMzOTg2XSBDYWxs
IHRyYWNlOgpbICAgIDMuNjMzOTkxXSAga2VybmZzX2NyZWF0ZV9kaXJfbnMrMHhhOC8weGIwClsg
ICAgMy42MzM5OTRdICBzeXNmc19jcmVhdGVfZGlyX25zKzB4NTQvMHhlOApbICAgIDMuNjM0MDAx
XSAga29iamVjdF9hZGRfaW50ZXJuYWwrMHgyMmMvMHgzZjAKWyAgICAzLjYzNDAwNV0gIGtvYmpl
Y3RfYWRkKzB4ZTQvMHgxMTgKWyAgICAzLjYzNDAxMV0gIGRldmljZV9hZGQrMHgyMDAvMHg4NzAK
WyAgICAzLjYzNDAxN10gIF9yZXF1ZXN0X2Zpcm13YXJlKzB4OTU4LzB4YzM4ClsgICAgMy42MzQw
MjBdICByZXF1ZXN0X2Zpcm13YXJlX2ludG9fYnVmKzB4NGMvMHg3MAouLi4uClsgICAgMy42MzQw
NjRdIGtlcm5lbCBCVUcgYXQgLi4uL21tL3NsdWIuYzoyOTQhCiAgICAgICAgICAgICAgICBIZXJl
IGlzIEJVR19PTihvYmplY3QgPT0gZnApIGluIHNldF9mcmVlcG9pbnRlcigpLgouLi4uClsgICAg
My42MzQzNDZdIENhbGwgdHJhY2U6ClsgICAgMy42MzQzNTFdICBrbWVtX2NhY2hlX2ZyZWUrMHg1
MDQvMHg2YjgKWyAgICAzLjYzNDM1NV0gIGtlcm5mc19wdXQrMHgxNGMvMHgxZDgKWyAgICAzLjYz
NDM1OV0gIGtlcm5mc19jcmVhdGVfZGlyX25zKzB4ODgvMHhiMApbICAgIDMuNjM0MzYyXSAgc3lz
ZnNfY3JlYXRlX2Rpcl9ucysweDU0LzB4ZTgKWyAgICAzLjYzNDM2Nl0gIGtvYmplY3RfYWRkX2lu
dGVybmFsKzB4MjJjLzB4M2YwClsgICAgMy42MzQzNzBdICBrb2JqZWN0X2FkZCsweGU0LzB4MTE4
ClsgICAgMy42MzQzNzRdICBkZXZpY2VfYWRkKzB4MjAwLzB4ODcwClsgICAgMy42MzQzNzhdICBf
cmVxdWVzdF9maXJtd2FyZSsweDk1OC8weGMzOApbICAgIDMuNjM0MzgxXSAgcmVxdWVzdF9maXJt
d2FyZV9pbnRvX2J1ZisweDRjLzB4NzAKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCkZpeGVzOiA3MjZlNDEw
OTc5MjAgKCJkcml2ZXJzOiBjb3JlOiBSZW1vdmUgZ2x1ZSBkaXJzIGZyb20gc3lzZnMgZWFybGll
ciIpCgpTaWduZWQtb2ZmLWJ5OiBNdWNodW4gU29uZyA8c211Y2h1bkBnbWFpbC5jb20+Ci0tLQog
ZHJpdmVycy9iYXNlL2NvcmUuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvY29yZS5jIGIvZHJpdmVycy9iYXNlL2Nv
cmUuYwppbmRleCA0YWVhYTBjOTJiZGEuLjUxMTI3NTVjNDNmYSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9iYXNlL2NvcmUuYworKysgYi9kcml2ZXJzL2Jhc2UvY29yZS5jCkBAIC0xNzM5LDggKzE3Mzks
OSBAQCBjbGFzc19kaXJfY3JlYXRlX2FuZF9hZGQoc3RydWN0IGNsYXNzICpjbGFzcywgc3RydWN0
IGtvYmplY3QgKnBhcmVudF9rb2JqKQogCiBzdGF0aWMgREVGSU5FX01VVEVYKGdkcF9tdXRleCk7
CiAKLXN0YXRpYyBzdHJ1Y3Qga29iamVjdCAqZ2V0X2RldmljZV9wYXJlbnQoc3RydWN0IGRldmlj
ZSAqZGV2LAotCQkJCQkgc3RydWN0IGRldmljZSAqcGFyZW50KQorc3RhdGljIHN0cnVjdCBrb2Jq
ZWN0ICpfX2dldF9kZXZpY2VfcGFyZW50KHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJCQkJICAgc3Ry
dWN0IGRldmljZSAqcGFyZW50LAorCQkJCQkgICBib29sIGxvY2spCiB7CiAJaWYgKGRldi0+Y2xh
c3MpIHsKIAkJc3RydWN0IGtvYmplY3QgKmtvYmogPSBOVUxMOwpAQCAtMTc3OSwxNCArMTc4MCwx
NiBAQCBzdGF0aWMgc3RydWN0IGtvYmplY3QgKmdldF9kZXZpY2VfcGFyZW50KHN0cnVjdCBkZXZp
Y2UgKmRldiwKIAkJCX0KIAkJc3Bpbl91bmxvY2soJmRldi0+Y2xhc3MtPnAtPmdsdWVfZGlycy5s
aXN0X2xvY2spOwogCQlpZiAoa29iaikgewotCQkJbXV0ZXhfdW5sb2NrKCZnZHBfbXV0ZXgpOwor
CQkJaWYgKCFsb2NrKQorCQkJCW11dGV4X3VubG9jaygmZ2RwX211dGV4KTsKIAkJCXJldHVybiBr
b2JqOwogCQl9CiAKIAkJLyogb3IgY3JlYXRlIGEgbmV3IGNsYXNzLWRpcmVjdG9yeSBhdCB0aGUg
cGFyZW50IGRldmljZSAqLwogCQlrID0gY2xhc3NfZGlyX2NyZWF0ZV9hbmRfYWRkKGRldi0+Y2xh
c3MsIHBhcmVudF9rb2JqKTsKIAkJLyogZG8gbm90IGVtaXQgYW4gdWV2ZW50IGZvciB0aGlzIHNp
bXBsZSAiZ2x1ZSIgZGlyZWN0b3J5ICovCi0JCW11dGV4X3VubG9jaygmZ2RwX211dGV4KTsKKwkJ
aWYgKCFsb2NrKQorCQkJbXV0ZXhfdW5sb2NrKCZnZHBfbXV0ZXgpOwogCQlyZXR1cm4gazsKIAl9
CiAKQEAgLTE3OTksNiArMTgwMiwxOSBAQCBzdGF0aWMgc3RydWN0IGtvYmplY3QgKmdldF9kZXZp
Y2VfcGFyZW50KHN0cnVjdCBkZXZpY2UgKmRldiwKIAlyZXR1cm4gTlVMTDsKIH0KIAorc3RhdGlj
IGlubGluZSBzdHJ1Y3Qga29iamVjdCAqZ2V0X2RldmljZV9wYXJlbnQoc3RydWN0IGRldmljZSAq
ZGV2LAorCQkJCQkJc3RydWN0IGRldmljZSAqcGFyZW50KQoreworCXJldHVybiBfX2dldF9kZXZp
Y2VfcGFyZW50KGRldiwgcGFyZW50LCBmYWxzZSk7Cit9CisKK3N0YXRpYyBpbmxpbmUgc3RydWN0
IGtvYmplY3QgKgorZ2V0X2RldmljZV9wYXJlbnRfbG9ja2VkX2lmX2dsdWVfZGlyKHN0cnVjdCBk
ZXZpY2UgKmRldiwKKwkJCQkgICAgIHN0cnVjdCBkZXZpY2UgKnBhcmVudCkKK3sKKwlyZXR1cm4g
X19nZXRfZGV2aWNlX3BhcmVudChkZXYsIHBhcmVudCwgdHJ1ZSk7Cit9CisKIHN0YXRpYyBpbmxp
bmUgYm9vbCBsaXZlX2luX2dsdWVfZGlyKHN0cnVjdCBrb2JqZWN0ICprb2JqLAogCQkJCSAgICBz
dHJ1Y3QgZGV2aWNlICpkZXYpCiB7CkBAIC0xODMxLDYgKzE4NDcsMTYgQEAgc3RhdGljIHZvaWQg
Y2xlYW51cF9nbHVlX2RpcihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBrb2JqZWN0ICpnbHVl
X2RpcikKIAltdXRleF91bmxvY2soJmdkcF9tdXRleCk7CiB9CiAKK3N0YXRpYyBpbmxpbmUgdm9p
ZCB1bmxvY2tfaWZfZ2x1ZV9kaXIoc3RydWN0IGRldmljZSAqZGV2LAorCQkJCSAgICAgIHN0cnVj
dCBrb2JqZWN0ICpnbHVlX2RpcikKK3sKKwkvKiBzZWUgaWYgd2UgbGl2ZSBpbiBhICJnbHVlIiBk
aXJlY3RvcnkgKi8KKwlpZiAoIWxpdmVfaW5fZ2x1ZV9kaXIoZ2x1ZV9kaXIsIGRldikpCisJCXJl
dHVybjsKKworCW11dGV4X3VubG9jaygmZ2RwX211dGV4KTsKK30KKwogc3RhdGljIGludCBkZXZp
Y2VfYWRkX2NsYXNzX3N5bWxpbmtzKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3QgZGV2
aWNlX25vZGUgKm9mX25vZGUgPSBkZXZfb2Zfbm9kZShkZXYpOwpAQCAtMjA0MCw3ICsyMDY2LDcg
QEAgaW50IGRldmljZV9hZGQoc3RydWN0IGRldmljZSAqZGV2KQogCXByX2RlYnVnKCJkZXZpY2U6
ICclcyc6ICVzXG4iLCBkZXZfbmFtZShkZXYpLCBfX2Z1bmNfXyk7CiAKIAlwYXJlbnQgPSBnZXRf
ZGV2aWNlKGRldi0+cGFyZW50KTsKLQlrb2JqID0gZ2V0X2RldmljZV9wYXJlbnQoZGV2LCBwYXJl
bnQpOworCWtvYmogPSBnZXRfZGV2aWNlX3BhcmVudF9sb2NrZWRfaWZfZ2x1ZV9kaXIoZGV2LCBw
YXJlbnQpOwogCWlmIChJU19FUlIoa29iaikpIHsKIAkJZXJyb3IgPSBQVFJfRVJSKGtvYmopOwog
CQlnb3RvIHBhcmVudF9lcnJvcjsKQEAgLTIwNTUsMTAgKzIwODEsMTIgQEAgaW50IGRldmljZV9h
ZGQoc3RydWN0IGRldmljZSAqZGV2KQogCS8qIGZpcnN0LCByZWdpc3RlciB3aXRoIGdlbmVyaWMg
bGF5ZXIuICovCiAJLyogd2UgcmVxdWlyZSB0aGUgbmFtZSB0byBiZSBzZXQgYmVmb3JlLCBhbmQg
cGFzcyBOVUxMICovCiAJZXJyb3IgPSBrb2JqZWN0X2FkZCgmZGV2LT5rb2JqLCBkZXYtPmtvYmou
cGFyZW50LCBOVUxMKTsKLQlpZiAoZXJyb3IpIHsKLQkJZ2x1ZV9kaXIgPSBnZXRfZ2x1ZV9kaXIo
ZGV2KTsKKworCWdsdWVfZGlyID0gZ2V0X2dsdWVfZGlyKGRldik7CisJdW5sb2NrX2lmX2dsdWVf
ZGlyKGRldiwgZ2x1ZV9kaXIpOworCisJaWYgKGVycm9yKQogCQlnb3RvIEVycm9yOwotCX0KIAog
CS8qIG5vdGlmeSBwbGF0Zm9ybSBvZiBkZXZpY2UgZW50cnkgKi8KIAllcnJvciA9IGRldmljZV9w
bGF0Zm9ybV9ub3RpZnkoZGV2LCBLT0JKX0FERCk7Ci0tIAoyLjE3LjEKCg==
--000000000000a7321e058810f18b--
