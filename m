Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C9AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2AB206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDDmLVQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDZKwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:52:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43240 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:52:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id i68so2004684lfi.10;
        Fri, 26 Apr 2019 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=vsR8ySLD6yBXgX6PecmysN5pE0cwvB9UCmcxpocKf7E=;
        b=RDDmLVQHWi5xILYq3iPttVTJlAB3/vpg4Dw/CQv+sOBdRT0G7G8o/XOzx/zKYNRz9L
         TSdHWf9vWKQHNdP2yHQSOJhjskmYm3mjwzHExCrUmLoSdXn5boJm96+HqnN1w4TIjlnt
         dbmocXtB8qs6wEu6+v77GrkAcm1tcsHACUiOerneLkYRxgdZO8L6qfuTV9OvMjSLkaPp
         RwXdpfE15I70AonD7kIN+4XjgyRBAPrsQ0GfNCDcj+VaFQXP4KHSnxM6xSCcJcD87ZV1
         FQv1ZK7ChS2KjU9kvF11WpoLStldRup3B5p/I9d9324WvJjJGfyq/MU1W7Lak19CPNIb
         COpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=vsR8ySLD6yBXgX6PecmysN5pE0cwvB9UCmcxpocKf7E=;
        b=ixaZhmG9ockvqbm0AFlEMwakLlo6hcosS82cwkLFhWjpOice6701jtstkKW5mhgOD0
         GsSO+Q+8eqjwWTjb1BTPqQX7Fqb2FnQbwztOmKmOtWzbCL9ZFDTG0sI/JT/ewJ3V+28P
         K4aK+KmjOOm8VR2dtLTeWXKOLtm2QrYSGh8Ic4WBGfX8zp57AjiRQGwlwfbWjtgabopb
         66joakVU85kRbdBftavmYC8kJc1CsOzNKWiD1OMDfj1+3f483ECLFhc8YhfWOTQas5al
         MjcwBbAVYSIGfJyJzm7XUPTvqFTXANvmAKmAA1FuofXG9sIx+1WQFRYzeyfTgTf+QIKH
         nN6g==
X-Gm-Message-State: APjAAAV3v0m9NIMFzHm/tqqE35eX2RUjJYwu6iOeqX7GmbHOr+uK2Y3e
        SBQX7jKtkvHl6sl9Z/5Oz5lLfQaUZn0=
X-Google-Smtp-Source: APXvYqxjz4EcXsr43DO/bjCx5ksNaanGdi1jLFLPARFhY+FZqowawgQVs0J0URU7fs7wNJKKfdBaEw==
X-Received: by 2002:a19:a94d:: with SMTP id s74mr9706467lfe.134.1556275949059;
        Fri, 26 Apr 2019 03:52:29 -0700 (PDT)
Received: from rd-oc (m90-139-62-104.cust.tele2.lv. [90.139.62.104])
        by smtp.gmail.com with ESMTPSA id j24sm2697761lfh.28.2019.04.26.03.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 03:52:28 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:52:24 +0300
From:   Reinis Danne <rei4dan@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, kbd@lists.altlinux.org
Subject: [RFC] tty: kb_value with flags for better Unicode support
Message-ID: <20190426105224.GB11020@rd-oc>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, kbd@lists.altlinux.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compliment already existing kbdiacruc and kbdiacrsuc structs and
KD[GS]KBDIACRUC ioctls with Unicode equivalents for kb_value, kbentry and
KD[GS]KBENT ioctls.

```
struct kb_valueuc {
	__u32 flags;		/* 15 used by KTYP */
	__u32 kb_valueuc;	/* Unicode range: 0x0–0x10ffff */
};

struct kbentryuc {
	__u32 kb_table;
	__u32 kb_index;
	struct kb_valueuc;
};

extern kb_valueuc *key_maps[MAX_NR_KEYMAPS];

#define KDGKBENTUC	0x????	/* get one entry in translation table */
#define KDSKBENTUC	0x????	/* set one entry in translation table */
```

Motivation
==========

Since I learned touchtyping, I want to have the same keyboard layout in VT as I
have in X.  So I wrote a keymap file for Latvian (modern) keyboard layout [1]
to use with the kbd package and it works, mostly.

I have three issues:
- Compose sequences with base above Latin-1 not working (fixed).
- CapsLock not working as expected for characters above Latin-1.
- Can't use Meta key with characters above Latin-1.

There are three letters above 0xff on level 1 of this keyboard layout:
ē — U+0113 Dec:275 LATIN SMALL LETTER E WITH MACRON
ā — U+0101 Dec:257 LATIN SMALL LETTER A WITH MACRON
ī — U+012B Dec:299 LATIN SMALL LETTER I WITH MACRON


Compose
=======

I have added some extra letters in the free places to be able to type not only
Latvian and English, but also German and Finnish (e.g., there is letter ö on
level 3 of ē key) for the rare occasions I need them.

This keyboard layout uses a dead key (dead_acute) to access level 3 symbols
(the same as AltGr):

compose diacr base to result
compose '\'' U+0113 to U+00F6

But it didn't work if the base in the compose sequence was above 0xff (patch
[2] is in tty-next).


Key value and flags
===================

The other two issues could be attributed to the lack of proper flags for key
values (key type is encoded in its value).

According to keymaps manual:
```
Each  keysym  may  be prefixed by a '+' (plus sign), in wich case this keysym
is treated as a "letter" and therefore affected by the "CapsLock" the same way
as by "Shift" (to be correct, the CapsLock inverts the Shift state).  The ASCII
letters ('a'-'z' and 'A'-'Z') are made CapsLock'able by default.  If
Shift+CapsLock should not produce a lower case symbol, put lines like

      keycode 30 = +a  A

in the map file.
```

But it doesn't work — CapsLock is ignored for codepoints above 0xff.  Adding
plus signs to all four maps should make them behave the same way (like in X):

#              0              1              2              3
#              Plain          Shift          AltGr          AltGr+Shift
keycode  16 = +U+0113        +U+0112        +U+00F6        +U+00D6

                          |     X       VT
--------------------------+---------------
CapsLock                ē |     Ē       ē
CapsLock+Shift          ē |     ē       Ē
CapsLock+AltGr          ē |     Ö       Ö
CapsLock+Shift+AltGr    ē |     ö       ö

For the key to behave properly, its key type (KTYP) has to be 'letter':

include/uapi/linux/keyboard.h:
#define KT_LETTER	11	/* symbol that can be acted upon by CapsLock */


Thus it is necessary to set KTYP for characters beyond Latin-1; which is not
possible now.

Currently they are defined like this:
```
include/linux/keyboard.h:

extern unsigned short *key_maps[MAX_NR_KEYMAPS];


drivers/tty/vt/defkeymap.c_shipped:

ushort *key_maps[MAX_NR_KEYMAPS] = {
	plain_map, shift_map, altgr_map, NULL,
	ctrl_map, shift_ctrl_map, NULL, NULL,
	alt_map, NULL, NULL, NULL,
	ctrl_alt_map, NULL
};


include/uapi/linux/kd.h:

struct kbentry {
	unsigned char kb_table;
	unsigned char kb_index;
	unsigned short kb_value;	<-- Important!
};


#define KDGKBENT	0x4B46	/* gets one entry in translation table */
#define KDSKBENT	0x4B47	/* sets one entry in translation table */


include/linux/kbd_kern.h:

#define U(x) ((x) ^ 0xf000)

#define BRL_UC_ROW 0x2800


include/uapi/linux/keyboard.h:

#define K(t,v)		(((t)<<8)|(v))
#define KTYP(x)		((x) >> 8)
#define KVAL(x)		((x) & 0xff)
```

The use of ``unsigned short kb_value`` in ``struct kbentry`` prevents setting
KTYP for Unicode characters beyond Latin-1 since there are only two bytes in an
``unsigned short`` and KTYP needs one, not leaving enough space for code points
beyond 0xff.

This breaks CapsLock for keyboard layouts with characters above Latin-1 [3–6].

I think those bugs are closed by mistake, since, to this day, it doesn't work.
And it can't work because of the aforementioned kernel limitations (at least as
far as CapsLock issue in Unicode mode is concerned).

To illustrate, keysym is 16 bits long:

	mmmm tttt nnnn nnnn

	m — mask for (non-)Unicode characters (U macro)
	t — KTYP
	n — KVAL

This also limits the number of Unicode characters — from 0xf000 the mask is
lost. (No Klingon input in VT [not that I want one]. I think
Documentation/admin-guide/unicode.rst talks only about the output. Or am I
missing something?)

See vt_do_kdsk_ioctl() and kbd_keycode() in drivers/tty/vt/keyboard.c for how
the mask and U macro is used.

As a side note: It seems CapsShift has never worked either.  It was suggested
as a workaround to this issue in one of the kernel bugs, but it obviously
wouldn't work.  First, CapsShift needs key map 256 and up (limited by
MAX_NR_KEYMAPS).  Second, in struct kbentry the kb_table index is unsigned char
(0–255).  So, even if one increased MAX_NR_KEYMAPS and recompiled the kernel,
they still wouldn't be able to set the key map, because the ioctl can't index
the table.


Solution
========

A possible fix could be a proper, extensible struct with flags [7] for
kb_value, used in the key_map[] and a pair of new ioctls (see the top of the
mail).

I think the increase in memory usage here is not something to worry about.

That would change key_map[] from ushort to __u64.  So instead of 2 bytes per
keysym, it would use 8 bytes.  The memory usage of keymaps would increase 4
times.  Since there are 7 keymaps by default with 256 keys each, that would
increase memory usage by:

	(8-2)*7*256=42*256=10752 B

Each additional keymap would increase memory usage by:

	8*256=2048 B

Increasing the size of kb_table and kb_index might be useful in the future for
adding multiple keyboard layout support to VT [8].

---
The increase of memory usage could be cut in half if ``__u32 flags`` is dropped
and KTYP is put at the last byte of ``__u32 kb_valueuc``:

#define K(t,v)		(((t)<<24)|(v))
#define KTYP(x)		((x) >> 24)
#define KVAL(x)		((x) & 0xffffff)

But in this case the future-proofing for flags [7,9] would be lost.

Also, there is possible conflict for programs built with old version of K
macros running on newer kernels.  The macros would have to be renamed.
---


Affected users
==============

KTYP or KVAL are used in (they would all have to be updated):
- kernel/debug/kdb/kdb_keyboard.c
- drivers/s390/char/keyboard.c
- drivers/s390/char/tty3270.c
- drivers/staging/speakup/main.c
- drivers/tty/vt/keyboard.c
- drivers/accessibility/braille/braille_console.c
- arch/m68k/atari/atakeyb.c

In addition to those, ``key_maps`` are used in:
- drivers/s390/char/defkeymap.c
- drivers/tty/vt/defkeymap.c_shipped
- drivers/input/keyboard/amikbd.c
- include/linux/keyboard.h
- arch/m68k/amiga/config.c

Also kbd package would have to be updated to take advantage of the change.


Is anybody already working on this? Maybe somebody has done it a long time ago
already, and I just have to do some magic incantations to make it work?

Is it even worth doing?

I'm new to kernel programming, comments from people with better insights are
very much appreciated.


-Reinis


[1] https://odo.lv/xwiki/bin/download/Recipes/LatvianKeyboard/Modern.png
[2] https://lkml.org/lkml/2019/4/11/362
[3] https://bugzilla.kernel.org/show_bug.cgi?id=7063
[4] https://bugzilla.kernel.org/show_bug.cgi?id=7746
[5] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=404503
[6] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/16638
[7] https://blog.ffwll.ch/2013/11/botching-up-ioctls.html
[8] https://www.happyassassin.net/2013/11/23/keyboard-layouts-in-fedora-20-and-previously/
[9] https://lwn.net/Articles/585415/
