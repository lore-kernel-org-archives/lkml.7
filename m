Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96844C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FB22147C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5E3Sp6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfDOPfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:35:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33346 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOPfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:35:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so8757354plo.0;
        Mon, 15 Apr 2019 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=jL0rxBSC6s9RA9Rb3xPj60KK/pnH46/tuYiS8X+w8P0=;
        b=j5E3Sp6J/IkmeIdaz+/kVg5KImcvzkzEPz+dJWLg7tG+HTS+O8Ug325+/7N2Ismj27
         iUhawidFeabncZclhJERBJVVMcWmnZxPTqnmslcvwo1twEX9ssZiRircHYRfDWQfBL2/
         y26yBgs4J4+20C8zgnPjvyFA4ZDhlcztee8Sx18jq/HRJ1Z/w5t95KGbMs1mMP9vrUqJ
         VLFiPHVlgzShTiPvvza3TT9b7MplzNKC/x+W0HYnVkfvrC+sURBNiIKBH2+0f8akNNRY
         mVCaBcypiF/MFUpHc8i0f5rwO8EcbNkQDSdw2b7olPktL0e7M98oCt7Ri5OznAMp/t+l
         DHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=jL0rxBSC6s9RA9Rb3xPj60KK/pnH46/tuYiS8X+w8P0=;
        b=I7zr0x3MDcRZEMWrxeVmWYYG+bwmJb04pS7UdbIaI6NvwXPKEMOVqF1h5kw+ELirkW
         WM1V/sey8aa/NrKr6hjGHdggek3wv4VAQgeaQHhoNPNKhJimONvvhay0lzeq9sgtUxh4
         MCcwOnKViqfBnbCM+HYzvmRf7xn+KBwO/sh6KvVvHu5qr5162H4d6QD9qa5Wfzeo3RFo
         5Nuuv5fTqFOsJMoMZuiy3UsXIFM2APMjgHm06VSMLiFrlADeP45fl64emEXQFVZD7bgw
         OQHwvwyFYfbNxkgPM3D//O3sqrUWBjUcTVOsvz4g6C6qSoUy4o7U/1uAiWigwxafZidQ
         MFpA==
X-Gm-Message-State: APjAAAUC4j1WIkNOc/bCJZu/wdjmAWRUODB3LnFsO6Wp9qknSOVlEBDG
        XONVgA985IH8Qz7Hq+1AnIg=
X-Google-Smtp-Source: APXvYqx1+Fg3Z20JdpB9F7yd6F+ySmsraixNxxcvtSk/wMhk98f0nf3Vn3DuEunYqfIe9dKTuDwGvA==
X-Received: by 2002:a17:902:141:: with SMTP id 59mr40118319plb.132.1555342504638;
        Mon, 15 Apr 2019 08:35:04 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:91ac:460f:1e02:116c? ([2601:282:800:fd80:91ac:460f:1e02:116c])
        by smtp.googlemail.com with ESMTPSA id j9sm66429132pfc.43.2019.04.15.08.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 08:35:03 -0700 (PDT)
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Julian Anastasov <ja@ssi.bg>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000007d22100573d66078@google.com>
 <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
 <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <dc7c06ae-204d-c287-04a4-d48875476d09@gmail.com>
Date:   Mon, 15 Apr 2019 09:35:01 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
Content-Type: multipart/mixed;
 boundary="------------DD0480AFFB91D4F7E35D2207"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DD0480AFFB91D4F7E35D2207
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 4/15/19 7:36 AM, Tetsuo Handa wrote:
> I traced using debug printk() patch shown below.
> 

I find tracepoints (see attached patch) and perf are easier to use to
debug device refcnt problems.

For example, limit the stack you have to deal with via sysctl -w
kernel.perf_event_max_stack=16, and add a filter (e.g., --filter 'name
== "lo"') to limit collection to a specific device.

--------------DD0480AFFB91D4F7E35D2207
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="0001-Add-tracepoints-to-dev_hold-and-dev_put.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Add-tracepoints-to-dev_hold-and-dev_put.patch"

RnJvbSAwNjhiMWI4MzYyZWM1ZmQxYjlkZmZkYmQ2ZTg0NDc0YWRhMmViODI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBBaGVybiA8ZHNhQGN1bXVsdXNuZXR3b3Jr
cy5jb20+CkRhdGU6IFRodSwgMTEgRmViIDIwMTYgMDI6NDA6MTIgLTA4MDAKU3ViamVjdDog
W1BBVENIXSBBZGQgdHJhY2Vwb2ludHMgdG8gZGV2X2hvbGQgYW5kIGRldl9wdXQKClNpZ25l
ZC1vZmYtYnk6IERhdmlkIEFoZXJuIDxkc2FAY3VtdWx1c25ldHdvcmtzLmNvbT4KLS0tCiBp
bmNsdWRlL2xpbnV4L25ldGRldmljZS5oICB8ICA2ICsrKysrKwogaW5jbHVkZS90cmFjZS9l
dmVudHMvbmV0LmggfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogbmV0L2NvcmUvZGV2LmMgICAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysr
KysKIDMgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvbmV0ZGV2aWNlLmggYi9pbmNsdWRlL2xpbnV4L25ldGRldmljZS5oCmlu
ZGV4IDIxOWY1M2MzMGNiMy4uN2VmNmZjNjcyZGZiIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xp
bnV4L25ldGRldmljZS5oCisrKyBiL2luY2x1ZGUvbGludXgvbmV0ZGV2aWNlLmgKQEAgLTMx
OTMsNiArMzE5Myw3IEBAIGV4dGVybiBpbnQJCW5ldGRldl9idWRnZXQ7CiAvKiBDYWxsZWQg
YnkgcnRuZXRsaW5rLmM6cnRubF91bmxvY2soKSAqLwogdm9pZCBuZXRkZXZfcnVuX3RvZG8o
dm9pZCk7CiAKKyNpZiAwCiAvKioKICAqCWRldl9wdXQgLSByZWxlYXNlIHJlZmVyZW5jZSB0
byBkZXZpY2UKICAqCUBkZXY6IG5ldHdvcmsgZGV2aWNlCkBAIC0zMjE0LDYgKzMyMTUsMTEg
QEAgc3RhdGljIGlubGluZSB2b2lkIGRldl9ob2xkKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYp
CiB7CiAJdGhpc19jcHVfaW5jKCpkZXYtPnBjcHVfcmVmY250KTsKIH0KKyNlbHNlCit2b2lk
IGRldl9wdXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldik7Cit2b2lkIGRldl9ob2xkKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYpOworCisjZW5kaWYKIAogLyogQ2FycmllciBsb3NzIGRldGVj
dGlvbiwgZGlhbCBvbiBkZW1hbmQuIFRoZSBmdW5jdGlvbnMgbmV0aWZfY2Fycmllcl9vbgog
ICogYW5kIF9vZmYgbWF5IGJlIGNhbGxlZCBmcm9tIElSUSBjb250ZXh0LCBidXQgaXQgaXMg
Y2FsbGVyCmRpZmYgLS1naXQgYS9pbmNsdWRlL3RyYWNlL2V2ZW50cy9uZXQuaCBiL2luY2x1
ZGUvdHJhY2UvZXZlbnRzL25ldC5oCmluZGV4IDQ5Y2M3YzNkZTI1Mi4uOWVkNzNkZmU5ZDA5
IDEwMDY0NAotLS0gYS9pbmNsdWRlL3RyYWNlL2V2ZW50cy9uZXQuaAorKysgYi9pbmNsdWRl
L3RyYWNlL2V2ZW50cy9uZXQuaApAQCAtMjM2LDYgKzIzNiw0NCBAQCBERUZJTkVfRVZFTlQo
bmV0X2Rldl9yeF92ZXJib3NlX3RlbXBsYXRlLCBuZXRpZl9yeF9uaV9lbnRyeSwKIAlUUF9B
UkdTKHNrYikKICk7CiAKK1RSQUNFX0VWRU5UKGRldl9wdXQsCisKKwlUUF9QUk9UTyhzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KSwKKworCVRQX0FSR1MoZGV2KSwKKworCVRQX1NUUlVDVF9f
ZW50cnkoCisJCV9fc3RyaW5nKAluYW1lLAkJZGV2LT5uYW1lCSkKKwkJX19maWVsZCgJaW50
LAkJcmVmY250ICkKKwkpLAorCisJVFBfZmFzdF9hc3NpZ24oCisJCV9fYXNzaWduX3N0cihu
YW1lLCBkZXYtPm5hbWUpOworCQlfX2VudHJ5LT5yZWZjbnQgPSBuZXRkZXZfcmVmY250X3Jl
YWQoZGV2KTsKKwkpLAorCisJVFBfcHJpbnRrKCJkZXY9JXMgcmVmY250ICVkIiwgX19nZXRf
c3RyKG5hbWUpLCBfX2VudHJ5LT5yZWZjbnQpCispOworCitUUkFDRV9FVkVOVChkZXZfaG9s
ZCwKKworCVRQX1BST1RPKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpLAorCisJVFBfQVJHUyhk
ZXYpLAorCisJVFBfU1RSVUNUX19lbnRyeSgKKwkJX19zdHJpbmcoCW5hbWUsCQlkZXYtPm5h
bWUJKQorCQlfX2ZpZWxkKAlpbnQsCQlyZWZjbnQgKQorCSksCisKKwlUUF9mYXN0X2Fzc2ln
bigKKwkJX19hc3NpZ25fc3RyKG5hbWUsIGRldi0+bmFtZSk7CisJCV9fZW50cnktPnJlZmNu
dCA9IG5ldGRldl9yZWZjbnRfcmVhZChkZXYpOworCSksCisKKwlUUF9wcmludGsoImRldj0l
cyByZWZjbnQgJWQiLCBfX2dldF9zdHIobmFtZSksIF9fZW50cnktPnJlZmNudCkKKyk7CisK
ICNlbmRpZiAvKiBfVFJBQ0VfTkVUX0ggKi8KIAogLyogVGhpcyBwYXJ0IG11c3QgYmUgb3V0
c2lkZSBwcm90ZWN0aW9uICovCmRpZmYgLS1naXQgYS9uZXQvY29yZS9kZXYuYyBiL25ldC9j
b3JlL2Rldi5jCmluZGV4IGYxMjg0ODM1YjhjOS4uOTlhYzA2N2FmZDE4IDEwMDY0NAotLS0g
YS9uZXQvY29yZS9kZXYuYworKysgYi9uZXQvY29yZS9kZXYuYwpAQCAtODExNywzICs4MTE3
LDI0IEBAIHN0YXRpYyBpbnQgX19pbml0IG5ldF9kZXZfaW5pdCh2b2lkKQogfQogCiBzdWJz
eXNfaW5pdGNhbGwobmV0X2Rldl9pbml0KTsKKworCit2b2lkIGRldl9wdXQoc3RydWN0IG5l
dF9kZXZpY2UgKmRldikKK3sKKwl0aGlzX2NwdV9kZWMoKmRldi0+cGNwdV9yZWZjbnQpOwor
CXRyYWNlX2Rldl9wdXQoZGV2KTsKK30KK0VYUE9SVF9TWU1CT0woZGV2X3B1dCk7CisKKy8q
KgorICogICAgICBkZXZfaG9sZCAtIGdldCByZWZlcmVuY2UgdG8gZGV2aWNlCisgKiAgICAg
IEBkZXY6IG5ldHdvcmsgZGV2aWNlCisgKgorICogSG9sZCByZWZlcmVuY2UgdG8gZGV2aWNl
IHRvIGtlZXAgaXQgZnJvbSBiZWluZyBmcmVlZC4KKyAqLwordm9pZCBkZXZfaG9sZChzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KQoreworCXRoaXNfY3B1X2luYygqZGV2LT5wY3B1X3JlZmNu
dCk7CisJdHJhY2VfZGV2X2hvbGQoZGV2KTsKK30KK0VYUE9SVF9TWU1CT0woZGV2X2hvbGQp
OwotLSAKMi4xLjQKCg==
--------------DD0480AFFB91D4F7E35D2207--
