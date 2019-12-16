Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CE2C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3F1206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEPSExo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfLPJu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:50:29 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:33697 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLPJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:50:29 -0500
Received: by mail-il1-f194.google.com with SMTP id r81so4970977ilk.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 01:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JFnwZ4o2A2lK7cZDY5iJ/y1MAUb5fZXHm3bjB5soJwU=;
        b=VEPSExo05MC7xG8P8qvhwi3HzMTW51LT6G4qNjgrxBgaWEwctD60OSjPQRuHFaaCLS
         VgB9J4aSt7ps1woEdmplFZWUqd0hAYyn0JTAkxgKhLY2IB+L1nmoRqbZi+t0yM53ihDF
         6WmBILhZ/cTPm27l14y6KB2cqIZ5zjhjZDANs+ubB9jNsgOfc3OQW6dMPciLQgds4tGE
         axUd0vqU+77nJ9bMIR25t9l2qLZ9OrTt8vyoyEQJAvZ/45WQssHruius0kij5vC0U5Ye
         MW6rnht0ds0J/YHMZhMex5h/lnOhO6FA/2embYaBw0bBrHDcqwUK0cxrbxMNMrgiYLh0
         6XGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFnwZ4o2A2lK7cZDY5iJ/y1MAUb5fZXHm3bjB5soJwU=;
        b=HL+g266ag6lCcv6z2Fb4/9rZ5hlYoedcNAuegwAsiny69jHTZ2MPDm0m6Dd1kt5N/E
         CBQLQw8V2n0JXAO6YIMVy9HfGXEyGHawsZ/+htKcs+IwZkuAwxrZAPqekWIRTYX4S4zc
         ELYYQvF1N2pfhB7M4W7amtv0paQHR8fhHKmvRH3LX5Py2mXxJosXN0CRVKUWNfJTHOpQ
         QJIGenYKYsqYqb0fh/TLHiM6edqYNKB221aT5OJ2DfMCMxyzpnDe8vifse+c4bQifm7d
         Ij3e+XgYoM8ONuvTPbnmkWAB3g1sTztJj+/OktNdiyJkiL0jlf4ceatk5VTf9t0c7Htw
         3rlg==
X-Gm-Message-State: APjAAAXn48NuJo+I5m7C6b8kICsuLxIIr5ZrHGDscLGAPFmyX4byRJdC
        9ir58UPHmiYKh5imOppeZH+P0cMRmutsUjSSPr4=
X-Google-Smtp-Source: APXvYqwjJ95uvLbJt1zvSoKoXvnn7kfYXzzbdDPMQAwazYkLmCXYigbsJvy4gblzXNJlE0g8gefxC3IHExsU+71mhaM=
X-Received: by 2002:a92:9507:: with SMTP id y7mr10996643ilh.243.1576489827802;
 Mon, 16 Dec 2019 01:50:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575932654.git.robin.murphy@arm.com> <8642045f0657c9e782cd698eb08777c9d4c10c8d.1575932654.git.robin.murphy@arm.com>
 <CANAwSgTtzAZJqpsD7uVKskTnDmrT1bs=JuHxnPrkpQKtnZLhvQ@mail.gmail.com> <2681192.H4ySjFOPB8@diego>
In-Reply-To: <2681192.H4ySjFOPB8@diego>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 16 Dec 2019 15:20:16 +0530
Message-ID: <CANAwSgTL-9VCFFj-+4xsLZOxKCHtjyN4P6fYnuRSOe7cZRiWew@mail.gmail.com>
Subject: Re: [PATCH 4/4] mfd: rk808: Convert RK805 to syscore/PM ops
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Soeren Moch <smoch@web.de>, linux-rockchip@lists.infradead.org
Content-Type: multipart/mixed; boundary="0000000000002e21d20599cf249e"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002e21d20599cf249e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko / Robin / Soeren,

On Mon, 16 Dec 2019 at 01:57, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Anand,
>
> Am Sonntag, 15. Dezember 2019, 19:51:50 CET schrieb Anand Moon:
> > On Tue, 10 Dec 2019 at 18:54, Robin Murphy <robin.murphy@arm.com> wrote=
:
> > >
> > > RK805 has the same kind of dual-role sleep/shutdown pin as RK809/RK81=
7,
> > > so it makes little sense for the driver to have to have two completel=
y
> > > different mechanisms to handle essentially the same thing. Bring RK80=
5
> > > in line with the RK809/RK817 flow to clean things up.
> > >
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
>
> [...]
>
> > I am sill getting the kernel warning on issue poweroff see below.
> > on my Rock960 Model A
> > I feel the reason for this is we now have two poweroff callback
> > 1  pm_power_off =3D rk808_device_shutdown
> > 2  rk8xx_syscore_shutdown
>
> Nope, the issue is just the i2c subsystem complaining that the
> Rocckhip i2c drives does not provide an atomic-transfer function, see
>         "No atomic I2C transfer handler for 'i2c-0'"
> in your warning.
>
> Somewhere it was suggested that the current transfer function just
> works as atomic as well.
>
>
> > In my investigation earlier common function for shutdown solve
> > the issue of clean shutdown.
>
> This is simply a result of your syscore-shutdown function running way to
> early, before the i2c subsystem switched to using atomic transfers.
>
> This also indicates that this would really be way to early, as other part=
s
> of the kernel could also still be running.
>

Yes, you are correct syscore-shutdown initiates
shutdown before all the device do clean shutdown.

So for best approach for clean atomic shutdown is to use
  /* driver model interfaces that don't relate to enumeration  */
        void (*shutdown)(struct i2c_client *client);
drop the registration of syscore and use core .i2c_shutdown.

I have prepare this patch on top of this series for RTF
This patch dose clean shutdown of all the devices before poweroff.
see the log below.

*Note*: This feature will likely break the clean reboot feature.
Rockchip device do not perform clean reboot as some of the IP
block are not released before clean reboot and it's remain stuck.
Like PCIe and MMC, We need to look into this as well.

Shutdown log of my RK3399 Rock960 Model A
[0] https://pastebin.com/peYxmzb7
------------------------------------------------------------------------
[  OK  ] Stopped LVM2 metadata daemon.
[  OK  ] Reached target Shutdown.
[  OK  ] Reached target Final Step.
[  OK  ] Closed LVM2 metadata daemon socket.
[  OK  ] Started Power-Off.
[  OK  ] Reached target Power-Off.
[  542.715237] systemd-shutdown[1]: Syncing filesystems and block devices.
[  543.158314] systemd-shutdown[1]: Sending SIGTERM to remaining processes.=
..
[  543.168469] systemd-journald[280]: Received SIGTERM from PID 1
(systemd-shutdow).
[  543.202968] systemd-shutdown[1]: Sending SIGKILL to remaining processes.=
..
[  543.212365] systemd-shutdown[1]: Unmounting file systems.
[  543.214708] [535]: Remounting '/' read-only in with options '(null)'.
[  543.229661] EXT4-fs (mmcblk1p1): re-mounted. Opts: (null)
[  543.239978] systemd-shutdown[1]: All filesystems unmounted.
[  543.240481] systemd-shutdown[1]: Deactivating swaps.
[  543.241052] systemd-shutdown[1]: All swaps deactivated.
[  543.241514] systemd-shutdown[1]: Detaching loop devices.
[  543.244806] systemd-shutdown[1]: All loop devices detached.
[  543.245307] systemd-shutdown[1]: Detaching DM devices.
[  543.245994] systemd-shutdown[1]: All DM devices detached.
[  543.246474] systemd-shutdown[1]: All filesystems, swaps, loop
devices and DM devices detached.
[  543.302732] systemd-shutdown[1]: Successfully changed into root pivot.
[  543.303356] systemd-shutdown[1]: Returning to initrd...
[  543.339679] shutdown[1]: Syncing filesystems and block devices.
[  543.341084] shutdown[1]: Sending SIGTERM to remaining processes...
[  543.348948] shutdown[1]: Sending SIGKILL to remaining processes...
[  543.356551] shutdown[1]: Unmounting file systems.
[  543.359097] sd-umoun[541]: Unmounting '/oldroot/sys/kernel/config'.
[  543.361716] sd-umoun[542]: Unmounting '/oldroot/sys/kernel/debug'.
[  543.364333] sd-umoun[543]: Unmounting '/oldroot/dev/mqueue'.
[  543.366765] sd-umoun[544]: Unmounting '/oldroot/dev/hugepages'.
[  543.369426] sd-umoun[545]: Unmounting '/oldroot/sys/fs/cgroup/memory'.
[  543.372338] sd-umoun[546]: Unmounting '/oldroot/sys/fs/cgroup/perf_event=
'.
[  543.375030] sd-umoun[547]: Unmounting '/oldroot/sys/fs/cgroup/cpu,cpuacc=
t'.
[  543.377744] sd-umoun[548]: Unmounting '/oldroot/sys/fs/cgroup/pids'.
[  543.380620] sd-umoun[549]: Unmounting '/oldroot/sys/fs/cgroup/blkio'.
[  543.383256] sd-umoun[550]: Unmounting '/oldroot/sys/fs/cgroup/hugetlb'.
[  543.386015] sd-umoun[551]: Unmounting '/oldroot/sys/fs/cgroup/devices'.
[  543.389114] sd-umoun[552]: Unmounting '/oldroot/sys/fs/cgroup/cpuset'.
[  543.391817] sd-umoun[553]: Unmounting '/oldroot/sys/fs/pstore'.
[  543.394401] sd-umoun[554]: Unmounting '/oldroot/sys/fs/cgroup/systemd'.
[  543.397245] sd-umoun[555]: Unmounting '/oldroot/sys/fs/cgroup/unified'.
[  543.400083] sd-umoun[556]: Unmounting '/oldroot/sys/fs/cgroup'.
[  543.402654] sd-umoun[557]: Unmounting '/oldroot/dev/pts'.
[  543.405351] sd-umoun[558]: Unmounting '/oldroot/dev/shm'.
[  543.407876] sd-umoun[559]: Unmounting '/oldroot/sys/kernel/security'.
[  543.410313] sd-umoun[560]: Unmounting '/oldroot'.
[  543.410886] sd-umoun[560]: Failed to unmount /oldroot: Device or
resource busy
[  543.413355] sd-umoun[561]: Unmounting '/oldroot/run'.
[  543.415750] sd-umoun[562]: Unmounting '/oldroot/dev'.
[  543.418013] sd-umoun[563]: Unmounting '/oldroot/sys'.
[  543.420892] sd-umoun[564]: Unmounting '/oldroot/proc'.
[  543.423833] sd-umoun[565]: Unmounting '/oldroot'.
[  543.486268] shutdown[1]: All filesystems unmounted.
[  543.486710] shutdown[1]: Deactivating swaps.
[  543.487153] shutdown[1]: All swaps deactivated.
[  543.487556] shutdown[1]: Detaching loop devices.
[  543.490300] shutdown[1]: All loop devices detached.
[  543.490735] shutdown[1]: Detaching DM devices.
[  543.491382] shutdown[1]: All DM devices detached.
[  543.491801] shutdown[1]: All filesystems, swaps, loop devices and
DM devices detached.
[  543.494678] shutdown[1]: Syncing filesystems and block devices.
[  543.495770] shutdown[1]: Powering off.
[  543.496112] kvm: exiting hardware virtualization

-Anand

--0000000000002e21d20599cf249e
Content-Type: application/octet-stream; name="i2c_shutdown.patch"
Content-Disposition: attachment; filename="i2c_shutdown.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k4891t990>
X-Attachment-Id: f_k4891t990

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL3JrODA4LmMgYi9kcml2ZXJzL21mZC9yazgwOC5jCmlu
ZGV4IGU4OGJkYjg4OWQzYS4uODIzODAzZGYyZDdiIDEwMDY0NAotLS0gYS9kcml2ZXJzL21mZC9y
azgwOC5jCisrKyBiL2RyaXZlcnMvbWZkL3JrODA4LmMKQEAgLTQ0OCwzNiArNDQ4LDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCByZWdtYXBfaXJxX2NoaXAgcms4MThfaXJxX2NoaXAgPSB7CiAKIHN0
YXRpYyBzdHJ1Y3QgaTJjX2NsaWVudCAqcms4MDhfaTJjX2NsaWVudDsKIAotc3RhdGljIHZvaWQg
cms4MDhfZGV2aWNlX3NodXRkb3duKHZvaWQpCi17Ci0JaW50IHJldDsKLQl1bnNpZ25lZCBpbnQg
cmVnLCBiaXQ7Ci0Jc3RydWN0IHJrODA4ICpyazgwOCA9IGkyY19nZXRfY2xpZW50ZGF0YShyazgw
OF9pMmNfY2xpZW50KTsKLQotCWlmICghcms4MDgpCi0JCXJldHVybjsKLQotCXN3aXRjaCAocms4
MDgtPnZhcmlhbnQpIHsKLQljYXNlIFJLODA1X0lEOgotCQlyZWcgPSBSSzgwNV9ERVZfQ1RSTF9S
RUc7Ci0JCWJpdCA9IERFVl9PRkY7Ci0JCWJyZWFrOwotCWNhc2UgUks4MDhfSUQ6Ci0JCXJlZyA9
IFJLODA4X0RFVkNUUkxfUkVHLAotCQliaXQgPSBERVZfT0ZGX1JTVDsKLQkJYnJlYWs7Ci0JY2Fz
ZSBSSzgxOF9JRDoKLQkJcmVnID0gUks4MThfREVWQ1RSTF9SRUc7Ci0JCWJpdCA9IERFVl9PRkY7
Ci0JCWJyZWFrOwotCWRlZmF1bHQ6Ci0JCXJldHVybjsKLQl9Ci0JcmV0ID0gcmVnbWFwX3VwZGF0
ZV9iaXRzKHJrODA4LT5yZWdtYXAsIHJlZywgYml0LCBiaXQpOwotCWlmIChyZXQpCi0JCWRldl9l
cnIoJnJrODA4X2kyY19jbGllbnQtPmRldiwgIkZhaWxlZCB0byBzaHV0ZG93biBkZXZpY2UhXG4i
KTsKLX0KLQorI2lmIDAKIHN0YXRpYyB2b2lkIHJrOHh4X3N5c2NvcmVfc2h1dGRvd24odm9pZCkK
IHsKIAlzdHJ1Y3Qgcms4MDggKnJrODA4ID0gaTJjX2dldF9jbGllbnRkYXRhKHJrODA4X2kyY19j
bGllbnQpOwpAQCAtNTExLDYgKzQ4Miw3IEBAIHN0YXRpYyB2b2lkIHJrOHh4X3N5c2NvcmVfc2h1
dGRvd24odm9pZCkKIHN0YXRpYyBzdHJ1Y3Qgc3lzY29yZV9vcHMgcms4MDhfc3lzY29yZV9vcHMg
PSB7CiAJLnNodXRkb3duID0gcms4eHhfc3lzY29yZV9zaHV0ZG93biwKIH07CisjZW5kaWYKIAog
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgcms4MDhfb2ZfbWF0Y2hbXSA9IHsKIAl7
IC5jb21wYXRpYmxlID0gInJvY2tjaGlwLHJrODA1IiB9LApAQCAtNjQzLDggKzYxNSw5IEBAIHN0
YXRpYyBpbnQgcms4MDhfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwKIAl9CiAKIAly
azgwOF9pMmNfY2xpZW50ID0gY2xpZW50OworI2lmIDAKIAlyZWdpc3Rlcl9zeXNjb3JlX29wcygm
cms4MDhfc3lzY29yZV9vcHMpOwotCisjZW5kaWYKIAlyZXQgPSBkZXZtX21mZF9hZGRfZGV2aWNl
cygmY2xpZW50LT5kZXYsIFBMQVRGT1JNX0RFVklEX05PTkUsCiAJCQkgICAgICBjZWxscywgbnJf
Y2VsbHMsIE5VTEwsIDAsCiAJCQkgICAgICByZWdtYXBfaXJxX2dldF9kb21haW4ocms4MDgtPmly
cV9kYXRhKSk7CkBAIC02NTMsMTMgKzYyNiwxNiBAQCBzdGF0aWMgaW50IHJrODA4X3Byb2JlKHN0
cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsCiAJCWdvdG8gZXJyX2lycTsKIAl9CiAKKyNpZiAwCiAJ
aWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgInJvY2tjaGlwLHN5c3RlbS1wb3dlci1jb250
cm9sbGVyIikpCiAJCXBtX3Bvd2VyX29mZiA9IHJrODA4X2RldmljZV9zaHV0ZG93bjsKLQorI2Vu
ZGlmCiAJcmV0dXJuIDA7CiAKIGVycl9pcnE6CisjaWYgMAogCXVucmVnaXN0ZXJfc3lzY29yZV9v
cHMoJnJrODA4X3N5c2NvcmVfb3BzKTsKKyNlbmRpZgogCXJlZ21hcF9kZWxfaXJxX2NoaXAoY2xp
ZW50LT5pcnEsIHJrODA4LT5pcnFfZGF0YSk7CiAJcmV0dXJuIHJldDsKIH0KQEAgLTY3MCwxOCAr
NjQ2LDQ4IEBAIHN0YXRpYyBpbnQgcms4MDhfcmVtb3ZlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQpCiAKIAlyZWdtYXBfZGVsX2lycV9jaGlwKGNsaWVudC0+aXJxLCByazgwOC0+aXJxX2RhdGEp
OwogCisjaWYgMAogCXVucmVnaXN0ZXJfc3lzY29yZV9vcHMoJnJrODA4X3N5c2NvcmVfb3BzKTsK
LQogCS8qKgogCSAqIHBtX3Bvd2VyX29mZiBtYXkgcG9pbnRzIHRvIGEgZnVuY3Rpb24gZnJvbSBh
bm90aGVyIG1vZHVsZS4KIAkgKiBDaGVjayBpZiB0aGUgcG9pbnRlciBpcyBzZXQgYnkgdXMgYW5k
IG9ubHkgdGhlbiBvdmVyd3JpdGUgaXQuCiAJICovCiAJaWYgKHBtX3Bvd2VyX29mZiA9PSByazgw
OF9kZXZpY2Vfc2h1dGRvd24pCiAJCXBtX3Bvd2VyX29mZiA9IE5VTEw7Ci0KKyNlbmRpZgogCXJl
dHVybiAwOwogfQogCitzdGF0aWMgdm9pZCByazgwOF9zaHV0ZG93bihzdHJ1Y3QgaTJjX2NsaWVu
dCAqY2xpZW50KQoreworCWludCByZXQ7CisJdW5zaWduZWQgaW50IHJlZywgYml0OworCXN0cnVj
dCByazgwOCAqcms4MDggPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKKworCWlmICghcms4
MDgpCisJCXJldHVybjsKKworCXN3aXRjaCAocms4MDgtPnZhcmlhbnQpIHsKKwljYXNlIFJLODA1
X0lEOgorCQlyZWcgPSBSSzgwNV9ERVZfQ1RSTF9SRUc7CisJCWJpdCA9IERFVl9PRkY7CisJCWJy
ZWFrOworCWNhc2UgUks4MDhfSUQ6CisJCXJlZyA9IFJLODA4X0RFVkNUUkxfUkVHLAorCQliaXQg
PSBERVZfT0ZGX1JTVDsKKwkJYnJlYWs7CisJY2FzZSBSSzgxOF9JRDoKKwkJcmVnID0gUks4MThf
REVWQ1RSTF9SRUc7CisJCWJpdCA9IERFVl9PRkY7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCXJl
dHVybjsKKwl9CisJcmV0ID0gcmVnbWFwX3VwZGF0ZV9iaXRzKHJrODA4LT5yZWdtYXAsIHJlZywg
Yml0LCBiaXQpOworCWlmIChyZXQpCisJCWRldl9lcnIoJnJrODA4X2kyY19jbGllbnQtPmRldiwg
IkZhaWxlZCB0byBzaHV0ZG93biBkZXZpY2UhXG4iKTsKK30KKwogc3RhdGljIGludCBfX21heWJl
X3VudXNlZCByazh4eF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3Qgcms4
MDggKnJrODA4ID0gaTJjX2dldF9jbGllbnRkYXRhKHJrODA4X2kyY19jbGllbnQpOwpAQCAtNzM3
LDYgKzc0Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciByazgwOF9pMmNfZHJpdmVyID0g
ewogCX0sCiAJLnByb2JlICAgID0gcms4MDhfcHJvYmUsCiAJLnJlbW92ZSAgID0gcms4MDhfcmVt
b3ZlLAorCS5zaHV0ZG93biAgPSByazgwOF9zaHV0ZG93biwKIH07CiAKIG1vZHVsZV9pMmNfZHJp
dmVyKHJrODA4X2kyY19kcml2ZXIpOwo=
--0000000000002e21d20599cf249e--
