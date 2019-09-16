Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BC1C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D97206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tsy6/lkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbfIPTqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:46:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42072 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfIPTqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:46:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so351690pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tpc27TVoQdolh3GVcSXdbT0CgJJTTA8d6G+12e/VeMI=;
        b=Tsy6/lkFUnSRd4MrlplKvp4f1deq/abh8RArdRSQq1H2l1rath3BaI+qil/Dv9WxO/
         XQqcGJy4iBO3bbA4FvjcuYkNINfPQ+rBoNFNCzm4ejeiroKrQycm+aLaZgUNLXFtCiwI
         WyMK0CMgX0GJfynI7u3W4r0WRaZqtQcX7awkxt87LQ5OVBJ3PS34OdbLoPtKAAc97Vde
         M2i3aaO6Lx5NM4OK1wMJr9ZG1jbZGIqNyOs+tiVkGnlDiplGGRBibUkeNMhPxMnuy/4j
         MzdZuFwR31OSM3YgGNee0m4K62AMfE+cyOpZVlajFK6YOnBhKpIJFl2maGNk0CcBVMY4
         7S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tpc27TVoQdolh3GVcSXdbT0CgJJTTA8d6G+12e/VeMI=;
        b=Brye2p9s4qNOToF7PoYR+s7vGsKO7ZfEPBWdMR2veCvommPautQBn6zxAI/DFuMy8s
         /HO3z0+e0emlR9HiDkoAQPh1pQgOsprLAA0oZIgI07BgiNBJtScqT3Z2zlk7AD0DQJ7b
         YUpH6ZhYzbofQrZXfw1wuBkUwQvOOOBD+b0pcLtE088By9GZvHRSgoaHusauRsmoixee
         2sDSZGHfo5fdEmCp6gTp7eTel+Ij8g1GDsQWdu04rNom9hCJlKFMz5cZ057vP9CmgzSM
         7gt9z9ywQPyh0d8y//BmK1ioxxWj/AGyXU0vnxLRDsmH8IE7Q2w7NMGNTyGefyL3l0Jn
         nF6g==
X-Gm-Message-State: APjAAAXUsTTJoWa8QGUXWttPchYv/XwPbHPM/i7Z3epy9H0dPQWmTTvq
        nfaNjg0r0d2NyTnQyKeCFssprJ9RNVIz9pMeW8SqTQ==
X-Google-Smtp-Source: APXvYqw9wcqmLQ8y755aMFv6+1HDhkpQ9kk4MdZnqLwRyIgTMC0ZyL1cMwU6Wud1aUYOknUb3Ch5DsqNSAn+55qoaCo=
X-Received: by 2002:a17:902:bb87:: with SMTP id m7mr1509760pls.179.1568663166308;
 Mon, 16 Sep 2019 12:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <7ef58eb00bc46b4ea3fe49a8c45cd2ff06292247.camel@perches.com>
 <CAKwvOdn6bMGZFAwH8iS5xD+Ce7oV8U6Fgi_SrFpCjo2-1hEUrw@mail.gmail.com> <a8290101e2720cac8b06613ec4cb91ffbfd69f05.camel@perches.com>
In-Reply-To: <a8290101e2720cac8b06613ec4cb91ffbfd69f05.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Sep 2019 12:45:55 -0700
Message-ID: <CAKwvOd=uzQJ_098ua5VuUuDaWqGQHncED4WWjNwNS0-CdE5mfw@mail.gmail.com>
Subject: Re: [rfc patch script] treewide conversion of __section(foo) to section("foo");
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cd67da0592b0dab3"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cd67da0592b0dab3
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 12, 2019 at 4:50 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-09-12 at 15:45 -0700, Nick Desaulniers wrote:
> > If you want to email me just the patch file (so I don't have to
> > copy+pasta from an email),
>
> Lazy... ;)

Says the Perl programmer...http://threevirtues.com/ ;)

>
> > I'd be happy to apply it and compile+boot test a few more arch's
> > than x86.

Looks like arm defconfig has an error:

arch/arm/mach-omap2/omap-wakeupgen.c:634:1: error: expected ';' after
top level declarator
./include/linux/irqchip.h:27:43: note: expanded from macro 'IRQCHIP_DECLARE'
#define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name,
compat, fn)
                                          ^
./include/linux/of.h:1304:3: note: expanded from macro 'OF_DECLARE_2'
                _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
                ^
./include/linux/of.h:1284:10: note: expanded from macro '_OF_DECLARE'
                __used __section("__" ## table ## "_of_table")          \
                       ^
./include/linux/compiler_attributes.h:232:77: note: expanded from
macro '__section'
#define __section(section)              __attribute__((__section__(section)))
                                                                            ^


and

drivers/clocksource/timer-atmel-pit.c:263:1: error: pasting formed
'"__"timer', an invalid preprocessing token
TIMER_OF_DECLARE(at91sam926x_pit, "atmel,at91sam9260-pit",
^
./include/linux/clocksource.h:263:2: note: expanded from macro
'TIMER_OF_DECLARE'
        OF_DECLARE_1_RET(timer, name, compat, fn)
        ^
./include/linux/of.h:1302:3: note: expanded from macro 'OF_DECLARE_1_RET'
                _OF_DECLARE(table, name, compat, fn, of_init_fn_1_ret)
                ^
./include/linux/of.h:1284:25: note: expanded from macro '_OF_DECLARE'
                __used __section("__" ## table ## "_of_table")          \
                                      ^



and modpost is broken:
drivers/cpufreq/cpufreq_conservative.mod.c:12:11: error: expected expression
__section(.gnu.linkonce.this_module) = {
          ^
1 error generated.




arm64 then had this issue:
drivers/clocksource/arm_arch_timer.c:1624:1: error: expected ';' after
top level declarator
./include/linux/clocksource.h:272:2: note: expanded from macro
'TIMER_ACPI_DECLARE'
        ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
        ^
./include/linux/acpi.h:1097:10: note: expanded from macro
'ACPI_DECLARE_PROBE_ENTRY'
                __used __section("__" ## table ## "_acpi_probe_table")  \
                       ^
./include/linux/compiler_attributes.h:232:77: note: expanded from
macro '__section'
#define __section(section)              __attribute__((__section__(section)))
                                                                            ^


Same problem (token pasting then concatenation of strings).


diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 1b7cda17c34e..71844dbc963b 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -21,7 +21,7 @@ extern struct thermal_governor
*__governor_thermal_table_end[];

 #define THERMAL_TABLE_ENTRY(table, name) \
  static typeof(name) *__thermal_table_entry_##name \
- __used __section("__" ## table ## "_thermal_table") = &name
+ __used __section("__" #table "_thermal_table") = &name

 #define THERMAL_GOVERNOR_DECLARE(name) THERMAL_TABLE_ENTRY(governor, name)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 24c1293d8717..5013725cdb92 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1094,7 +1094,7 @@ struct acpi_probe_entry {

 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable,
valid, data, fn) \
  static const struct acpi_probe_entry __acpi_probe_##name \
- __used __section("__" ## table ## "_acpi_probe_table") \
+ __used __section("__" #table "_acpi_probe_table") \
  = { \
  .id = table_id, \
  .type = subtable, \
diff --git a/include/linux/of.h b/include/linux/of.h
index 71e74771ce35..b2459fc411cf 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1281,7 +1281,7 @@ static inline int
of_get_available_child_count(const struct device_node *np)
 #if defined(CONFIG_OF) && !defined(MODULE)
 #define _OF_DECLARE(table, name, compat, fn, fn_type) \
  static const struct of_device_id __of_table_##name \
- __used __section("__" ## table ## "_of_table") \
+ __used __section("__" #table "_of_table") \
  = { .compatible = compat, \
       .data = (fn == (fn_type)NULL) ? fn : fn  }
 #else
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 820eed87fb43..f2c70d1d5a2a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2176,7 +2176,7 @@ static void add_header(struct buffer *b, struct
module *mod)
  buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
  buf_printf(b, "\n");
  buf_printf(b, "__visible struct module __this_module\n");
- buf_printf(b, "__section(.gnu.linkonce.this_module) = {\n");
+ buf_printf(b, "__section(\".gnu.linkonce.this_module\") = {\n");
  buf_printf(b, "\t.name = KBUILD_MODNAME,\n");
  if (mod->has_init)
  buf_printf(b, "\t.init = init_module,\n");

-- 
Thanks,
~Nick Desaulniers

--000000000000cd67da0592b0dab3
Content-Type: text/plain; charset="US-ASCII"; name="patch.txt"
Content-Disposition: attachment; filename="patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k0mtb15y0>
X-Attachment-Id: f_k0mtb15y0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuaCBiL2RyaXZlcnMvdGhl
cm1hbC90aGVybWFsX2NvcmUuaAppbmRleCAxYjdjZGExN2MzNGUuLjcxODQ0ZGJjOTYzYiAxMDA2
NDQKLS0tIGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5oCisrKyBiL2RyaXZlcnMvdGhl
cm1hbC90aGVybWFsX2NvcmUuaApAQCAtMjEsNyArMjEsNyBAQCBleHRlcm4gc3RydWN0IHRoZXJt
YWxfZ292ZXJub3IgKl9fZ292ZXJub3JfdGhlcm1hbF90YWJsZV9lbmRbXTsKIAogI2RlZmluZSBU
SEVSTUFMX1RBQkxFX0VOVFJZKHRhYmxlLCBuYW1lKQkJCVwKIAlzdGF0aWMgdHlwZW9mKG5hbWUp
ICpfX3RoZXJtYWxfdGFibGVfZW50cnlfIyNuYW1lCVwKLQlfX3VzZWQgX19zZWN0aW9uKCJfXyIg
IyMgdGFibGUgIyMgIl90aGVybWFsX3RhYmxlIikgPSAmbmFtZQorCV9fdXNlZCBfX3NlY3Rpb24o
Il9fIiAjdGFibGUgIl90aGVybWFsX3RhYmxlIikgPSAmbmFtZQogCiAjZGVmaW5lIFRIRVJNQUxf
R09WRVJOT1JfREVDTEFSRShuYW1lKQlUSEVSTUFMX1RBQkxFX0VOVFJZKGdvdmVybm9yLCBuYW1l
KQogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L29mLmggYi9pbmNsdWRlL2xpbnV4L29mLmgK
aW5kZXggNzFlNzQ3NzFjZTM1Li5iMjQ1OWZjNDExY2YgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvb2YuaAorKysgYi9pbmNsdWRlL2xpbnV4L29mLmgKQEAgLTEyODEsNyArMTI4MSw3IEBAIHN0
YXRpYyBpbmxpbmUgaW50IG9mX2dldF9hdmFpbGFibGVfY2hpbGRfY291bnQoY29uc3Qgc3RydWN0
IGRldmljZV9ub2RlICpucCkKICNpZiBkZWZpbmVkKENPTkZJR19PRikgJiYgIWRlZmluZWQoTU9E
VUxFKQogI2RlZmluZSBfT0ZfREVDTEFSRSh0YWJsZSwgbmFtZSwgY29tcGF0LCBmbiwgZm5fdHlw
ZSkJCQlcCiAJc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgX19vZl90YWJsZV8jI25h
bWUJCVwKLQkJX191c2VkIF9fc2VjdGlvbigiX18iICMjIHRhYmxlICMjICJfb2ZfdGFibGUiKQkJ
XAorCQlfX3VzZWQgX19zZWN0aW9uKCJfXyIgI3RhYmxlICJfb2ZfdGFibGUiKQkJXAogCQkgPSB7
IC5jb21wYXRpYmxlID0gY29tcGF0LAkJCQlcCiAJCSAgICAgLmRhdGEgPSAoZm4gPT0gKGZuX3R5
cGUpTlVMTCkgPyBmbiA6IGZuICB9CiAjZWxzZQpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9tb2QvbW9k
cG9zdC5jIGIvc2NyaXB0cy9tb2QvbW9kcG9zdC5jCmluZGV4IDgyMGVlZDg3ZmI0My4uZjJjNzBk
MWQ1YTJhIDEwMDY0NAotLS0gYS9zY3JpcHRzL21vZC9tb2Rwb3N0LmMKKysrIGIvc2NyaXB0cy9t
b2QvbW9kcG9zdC5jCkBAIC0yMTc2LDcgKzIxNzYsNyBAQCBzdGF0aWMgdm9pZCBhZGRfaGVhZGVy
KHN0cnVjdCBidWZmZXIgKmIsIHN0cnVjdCBtb2R1bGUgKm1vZCkKIAlidWZfcHJpbnRmKGIsICJN
T0RVTEVfSU5GTyhuYW1lLCBLQlVJTERfTU9ETkFNRSk7XG4iKTsKIAlidWZfcHJpbnRmKGIsICJc
biIpOwogCWJ1Zl9wcmludGYoYiwgIl9fdmlzaWJsZSBzdHJ1Y3QgbW9kdWxlIF9fdGhpc19tb2R1
bGVcbiIpOwotCWJ1Zl9wcmludGYoYiwgIl9fc2VjdGlvbiguZ251LmxpbmtvbmNlLnRoaXNfbW9k
dWxlKSA9IHtcbiIpOworCWJ1Zl9wcmludGYoYiwgIl9fc2VjdGlvbihcIi5nbnUubGlua29uY2Uu
dGhpc19tb2R1bGVcIikgPSB7XG4iKTsKIAlidWZfcHJpbnRmKGIsICJcdC5uYW1lID0gS0JVSUxE
X01PRE5BTUUsXG4iKTsKIAlpZiAobW9kLT5oYXNfaW5pdCkKIAkJYnVmX3ByaW50ZihiLCAiXHQu
aW5pdCA9IGluaXRfbW9kdWxlLFxuIik7Cg==
--000000000000cd67da0592b0dab3--
