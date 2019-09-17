Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35659C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF3A21848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/NbGhcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfIQWHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 18:07:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42899 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfIQWHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:07:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id c10so4509906otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0qZAY6VQmy+DSvMfmGyag0U1BbvRutudcapQANj8u4=;
        b=S/NbGhcqgpKtU/BymKWjGp34ayujqyzXjurAVg6G8nIkC8KYk9X1k6j2hEjVUszr13
         kt5oHoOAFEbk4wl6CRFt2frbTGn1cpUawfFtZoBEVYAqPygL1v/jTWKfxUwF8F/OPWc+
         FxDn7Mjju0kWTuWEKwBCt6e3mdAHQ9WCRAx9m58QZS8rllxdFsTEprgmb5eZKxojIA2X
         AxW1FZuhjlU76Ni3SOlpdveTl5H1mYoz+5bPFPsV5/SBuW4oSeBqX2zjUCp8xDQK9K+q
         hxFFVOogPK+9Gwty70reWn4fpV8PPwQGCEDXof0EuDFiGG+vPq5opkfVXLjnUqbtPtbF
         HbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0qZAY6VQmy+DSvMfmGyag0U1BbvRutudcapQANj8u4=;
        b=e7Kx9luIQ7s1XUw2bn2iUwDpi8aufCeDiXserOnaoL9hnask+pmGekI0X2HvfhuXJL
         X8Kr/zSj0pwwx+4lP9FU3V+70LrtsnZu0wuM8aWiS6ymoXj4FCBKxw3eFd8N5i0DlPnS
         iQC8qeZRW0rC/GVWJ5cPh7VVrdPYiFKfO9SW322u5xHUQBKA1IDFtD8YxvyEURXnd2G1
         EISD6FuTwwCP/iU7jttKH1WC3WvUDBR0A6Jre8M++DOSguN35/waoyoACKNgoAgaTKdR
         NddsXGjvwqZDpwASWTy2T4COjisdFmN5ZPhh7yDhxzL/gVTtcDYYQnBtu0eqDhnzsR2U
         tbSA==
X-Gm-Message-State: APjAAAXNFg/o5dDbW4i3mAn7uivmoKTVVIAaqqU6aN/74WZ0Zpk2wFdQ
        1Wo8jT8xAD21cevp8/P+0iQ7RQbuKGgC8KgXKkI=
X-Google-Smtp-Source: APXvYqxHXzJvd+MjAvhSBStFigR0kYQOjHAP+c8uFOyUf7g1s5RDTv66B4J9buIUp1a01WfZcUQxb1iSE4fqxu1Cev0=
X-Received: by 2002:a05:6830:1e84:: with SMTP id n4mr478190otr.141.1568758049206;
 Tue, 17 Sep 2019 15:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190917035604.GA11126@gregn.net> <CAOtcWM25p0gJL9MAAK2pA7Ju9hOA4Z-0ngWTpFU5qemhOVsGyQ@mail.gmail.com>
In-Reply-To: <CAOtcWM25p0gJL9MAAK2pA7Ju9hOA4Z-0ngWTpFU5qemhOVsGyQ@mail.gmail.com>
From:   Okash Khawaja <okash.khawaja@gmail.com>
Date:   Tue, 17 Sep 2019 23:07:17 +0100
Message-ID: <CAOtcWM3aAyL_oBDZf4v9H=km4PshLZBFovJiGJjsvqF5uasf7A@mail.gmail.com>
Subject: Re: Re: [HELP REQUESTED from the community] Was: Staging status of speakup
To:     Gregory Nowak <greg@gregn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, linux-kernel@vger.kernel.org,
        John Covici <covici@ccs.covici.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah it looks like the spaces after Description: need to be converted into tabs.

Thanks,
Okash

On Tue, Sep 17, 2019 at 10:35 PM Okash Khawaja <okash.khawaja@gmail.com> wrote:
>
> Hi Greg,
>
> You're right, I got none of those emails. Thanks. Is it all taken care of?
>
> Best regards,
> Okash
>
> On Tue, Sep 17, 2019 at 4:56 AM Gregory Nowak <greg@gregn.net> wrote:
> >
> > Hi Okash,
> > I just realized the below didn't go to you directly along with the
> > other addresses.
> >
> > Greg
> >
> >
> > ----- Forwarded message from Gregory Nowak <greg@gregn.net> -----
> >
> > Date: Mon, 16 Sep 2019 15:38:48 -0700
> > From: Gregory Nowak <greg@gregn.net>
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: devel@driverdev.osuosl.org, Simon Dickson <simonhdickson@gmail.com>,
> >         "Speakup is a screen review system for Linux."
> >         <speakup@linux-speakup.org>, linux-kernel@vger.kernel.org, John Covici
> >         <covici@ccs.covici.com>
> > Subject: Re: [HELP REQUESTED from the community] Was: Staging status of speakup
> >
> > On Mon, Sep 16, 2019 at 04:11:00PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Sep 16, 2019 at 03:47:28PM +0200, Samuel Thibault wrote:
> > > > Okash Khawaja, le dim. 15 sept. 2019 19:41:30 +0100, a ecrit:
> > > > > I have attached the descriptions.
> > > >
> > > > Attachment is missing :)
> > >
> > > I saw it :)
> > >
> > > Anyway, please put the Description: lines without a blank after that,
> > > with the description text starting on that same line.
> > >
> > > thanks!
> > >
> > > greg k-h
> >
> > It's attached. Hope the indentation is OK.
> >
> > Greg
> >
> >
> > --
> > web site: http://www.gregn.net
> > gpg public key: http://www.gregn.net/pubkey.asc
> > skype: gregn1
> > (authorization required, add me to your contacts list first)
> > If we haven't been in touch before, e-mail me before adding me to your contacts.
> >
> > --
> > Free domains: http://www.eu.org/ or mail dns-manager@EU.org
> >
> > What:           /sys/accessibility/speakup/attrib_bleep
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Beeps the PC speaker when there is an attribute change such as
> >                 foreground or background color when using speakup review
> >                 commands. One = on, zero = off.
> > What:           /sys/accessibility/speakup/bell_pos
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This works much like a typewriter bell. If for example 72 is
> >                 echoed to bell_pos, it will beep the PC speaker when typing on
> >                 a line past character 72.
> > What:           /sys/accessibility/speakup/bleeps
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This controls whether one hears beeps through the PC speaker
> >                 when using speakup's review commands.
> >                 TODO: what values does it accept?
> > What:           /sys/accessibility/speakup/bleep_time
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This controls the duration of the PC speaker beeps speakup
> >                 produces.
> >                 TODO: What are the units? Jiffies?
> > What:           /sys/accessibility/speakup/cursor_time
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This controls cursor delay when using arrow keys. When a
> >                 connection is very slow, with the default setting, when moving
> >                 with  the arrows, or backspacing etc. speakup says the incorrect
> >                 characters. Set this to a higher value to adjust for the delay
> >                 and better synchronisation between cursor position and speech.
> > What:           /sys/accessibility/speakup/delimiters
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Delimit a word from speakup.
> >                 TODO: add more info
> > What:           /sys/accessibility/speakup/ex_num
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  TODO:
> > What:           /sys/accessibility/speakup/key_echo
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Controls if speakup speaks keys when they are typed. One = on,
> >                 zero = off or don't echo keys.
> > What:           /sys/accessibility/speakup/keymap
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Speakup keymap remaps keys to Speakup functins. It uses a binary
> >                 format. A special program called genmap is needed to compile a
> >                 textual  keymap into the binary format which is then loaded into
> >                 /sys/accessibility/speakup/keymap.
> > What:           /sys/accessibility/speakup/no_interrupt
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Controls if typing interrupts output from speakup. With
> >                 no_interrupt set to zero, typing on the keyboard will interrupt
> >                 speakup if for example the say screen command is used before the
> >                 entire screen  is read. With no_interrupt set to one, if the say
> >                 screen command is used, and one then types on the keyboard,
> >                 speakup will continue to say the whole screen regardless until
> >                 it finishes.
> > What:           /sys/accessibility/speakup/punc_all
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This is a list of all the punctuation speakup should speak when
> >                 punc_level is set to four.
> > What:           /sys/accessibility/speakup/punc_level
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Controls the level of punctuation spoken as the screen is
> >                 displayed, not reviewed. Levels range from zero no punctuation,
> >                 to four, all punctuation. One corresponds to punc_some, two
> >                 corresponds to punc_most, and three as well as four both
> >                 correspond to punc_all. Some hardware synthesizers may have
> >                 different levels each corresponding to  three and four for
> >                 punc_level. Also note that if punc_level is set to zero, and
> >                 key_echo is set to one, typed punctuation is still spoken as it
> >                 is typed.
> > What:           /sys/accessibility/speakup/punc_most
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This is a list of all the punctuation speakup should speak when
> >                 punc_level is set to two.
> > What:           /sys/accessibility/speakup/punc_some
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This is a list of all the punctuation speakup should speak when
> >                 punc_level is set to one.
> > What:           /sys/accessibility/speakup/reading_punc
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Almost the same as punc_level, the differences being that
> >                 reading_punc controls the level of punctuation when reviewing
> >                 the screen with speakup's screen review commands. The other
> >                 difference is that reading_punc set to three speaks punc_all,
> >                 and reading_punc set to four speaks all punctuation, including
> >                 spaces.
> > What:           /sys/accessibility/speakup/repeats
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  A list of characters speakup repeats. Normally, when there are
> >                 more than three characters in a row, speakup just reads three of
> >                 those characters. For example, "......" would be read as dot,
> >                 dot, dot. If a . is added to the list of characters in repeats,
> >                 "......" would be read as dot, dot, dot, times six.
> > What:           /sys/accessibility/speakup/say_control
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  If set to one, speakup speaks shift, alt and control when those
> >                 keys are pressed. If say_control is set to zero, shift, ctrl,
> >                 and alt are not spoken when they are pressed.
> > What:           /sys/accessibility/speakup/say_word_ctl
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  TODO:
> > What:           /sys/accessibility/speakup/silent
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  TODO:
> > What:           /sys/accessibility/speakup/spell_delay
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This controls how fast a word is spelled when speakup's say word
> >                 review command is pressed twice quickly to speak the current
> >                 word being reviewed. Zero just speaks the letters one after
> >                 another, while values one through four seem to introduce more of
> >                 a pause between the spelling of each letter by speakup.
> > What:           /sys/accessibility/speakup/synth
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Gets or sets the synthesizer driver currently in use. Reading
> >                 synth returns the synthesizer driver currently in use. Writing
> >                 synth switches to the given synthesizer driver, provided it is
> >                 either built into the kernel, or already loaded as a module.
> > What:           /sys/accessibility/speakup/synth_direct
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Sends whatever is written to synth_direct
> >                 directly to the speech synthesizer in use, bypassing speakup.
> >                 This could be used to make the synthesizer speak a string, or to
> >                 send control sequences to the synthesizer to change how the
> >                 synthesizer behaves.
> > What:           /sys/accessibility/speakup/version
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Reading version returns the version of speakup, and the version
> >                 of the synthesizer driver currently in use.
> > What:           /sys/accessibility/speakup/i18n/announcements
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This file contains various general announcements, most of which
> >                 cannot be categorized.  You will find messages such as "You
> >                 killed Speakup", "I'm alive", "leaving help", "parked",
> >                 "unparked", and others. You will also find the names of the
> >                 screen edges and cursor tracking modes here.
> > What:           /sys/accessibility/speakup/i18n/chartab
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  TODO
> > What:           /sys/accessibility/speakup/i18n/ctl_keys
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Here, you will find names of control keys.  These are used with
> >                 Speakup's say_control feature.
> > What:           /sys/accessibility/speakup/i18n/function_names
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Here, you will find a list of names for Speakup functions.
> >                 These are used by the help system.  For example, suppose that
> >                 you have activated help mode, and you pressed keypad 3.  Speakup
> >                 says: "keypad 3 is character, say next."
> >                 The message "character, say next" names a Speakup function, and
> >                 it comes from this function_names file.
> > What:           /sys/accessibility/speakup/i18n/states
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This file contains names for key states.
> >                 Again, these are part of the help system.  For instance, if you
> >                 had pressed speakup + keypad 3, you would hear:
> >                 "speakup keypad 3 is go to bottom edge."
> >                 The speakup key is depressed, so the name of the key state is
> >                 speakup.
> >                 This part of the message comes from the states collection.
> > What:           /sys/accessibility/speakup/i18n/characters
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Through this sys entry, Speakup gives you the ability to change
> >                 how Speakup pronounces a given character. You could, for
> >                 example, change how some punctuation characters are spoken. You
> >                 can even change how Speakup will pronounce certain letters. For
> >                 further details see '12.  Changing the Pronunciation of
> >                 Characters' in Speakup User's Guide (file spkguide.txt in
> >                 source).
> > What:           /sys/accessibility/speakup/i18n/colors
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  When you use the "say attributes" function, Speakup says the
> >                 name of the foreground and background colors.  These names come
> >                 from the i18n/colors file.
> > What:           /sys/accessibility/speakup/i18n/formatted
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This group of messages contains embedded formatting codes, to
> >                 specify the type and width of displayed data.  If you change
> >                 these, you must preserve all of the formatting codes, and they
> >                 must appear in the order used by the default messages.
> > What:           /sys/accessibility/speakup/i18n/key_names
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Again, key_names is used by Speakup's help system.  In the
> >                 previous example, Speakup said that you pressed "keypad 3."
> >                 This name came from the key_names file.
> > What:           /sys/accessibility/speakup/<synth-name>/
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  In `/sys/accessibility/speakup` is a directory corresponding to
> >                 the synthesizer driver currently in use (E.G) `soft` for the
> >                 soft driver. This directory contains files which control the
> >                 speech synthesizer itself, as opposed to controlling the speakup
> >                 screen reader. The parameters in this directory have the same
> >                 names and functions across all supported synthesizers. The range
> >                 of values for freq, pitch, rate, and vol is the same for all
> >                 supported synthesizers, with the given range being internally
> >                 mapped by the driver to  more or less fit the range of values
> >                 supported for a given parameter by the individual synthesizer.
> >                 Below is a description of values and  parameters for soft
> >                 synthesizer, which is currently the most commonly used.
> > What:           /sys/accessibility/speakup/soft/caps_start
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This is the string that is sent to the synthesizer to cause it
> >                 to start speaking uppercase letters. For the soft synthesizer
> >                 and most others, this causes the pitch of the voice to rise
> >                 above the currently set pitch.
> > What:           /sys/accessibility/speakup/soft/caps_stop
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This is the string sent to the synthesizer to cause it to stop
> >                 speaking uppercase letters. In the case of the soft synthesizer
> >                 and most others, this returns the pitch of the voice down to the
> >                 currently set pitch.
> > What:           /sys/accessibility/speakup/soft/delay_time
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  TODO:
> > What:           /sys/accessibility/speakup/soft/direct
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Controls if punctuation is spoken by speakup, or by the
> >                 synthesizer. For example, speakup speaks ">" as "greater", while
> >                 the espeak synthesizer used by the soft driver speaks "greater
> >                 than". Zero lets speakup speak the punctuation. One lets the
> >                 synthesizer itself speak punctuation.
> > What:           /sys/accessibility/speakup/soft/freq
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Gets or sets the frequency of the speech synthesizer. Range is
> >                 0-9.
> > What:           /sys/accessibility/speakup/soft/full_time
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  TODO:
> > What:           /sys/accessibility/speakup/soft/jiffy_delta
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  This controls how many jiffys the kernel gives to the
> >                 synthesizer. Setting this too high can make a system unstable,
> >                 or even crash it.
> > What:           /sys/accessibility/speakup/soft/pitch
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Gets or sets the pitch of the synthesizer. The range is 0-9.
> > What:           /sys/accessibility/speakup/soft/punct
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Gets or sets the amount of punctuation spoken by the
> >                 synthesizer. The range for the soft driver seems to be 0-2.
> >                 TODO: How is this related to speakup's punc_level, or
> >                 reading_punc.
> > What:           /sys/accessibility/speakup/soft/rate
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Gets or sets the rate of the synthesizer. Range is from zero
> >                 slowest, to nine fastest.
> > What:           /sys/accessibility/speakup/soft/tone
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Gets or sets the tone of the speech synthesizer. The range for
> >                 the soft driver seems to be 0-2. This seems to make no
> >                 difference if using espeak and the espeakup connector.
> >                 TODO: does espeakup support different tonalities?
> > What:           /sys/accessibility/speakup/soft/trigger_time
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  TODO:
> > What:           /sys/accessibility/speakup/soft/voice
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Gets or sets the voice used by the synthesizer if the
> >                 synthesizer can speak in more than one voice. The range for the
> >                 soft driver is 0-7. Note that while espeak supports multiple
> >                 voices, this parameter will not set the voice when the espeakup
> >                 connector is used  between speakup and espeak.
> > What:           /sys/accessibility/speakup/soft/vol
> > KernelVersion:  2.6
> > Contact:        speakup@linux-speakup.org
> > Description:  Gets or sets the volume of the speech synthesizer. Range is 0-9,
> >                 with zero being the softest, and nine being the loudest.
> >
> > _______________________________________________
> > Speakup mailing list
> > Speakup@linux-speakup.org
> > http://linux-speakup.org/cgi-bin/mailman/listinfo/speakup
> >
> >
> > ----- End forwarded message -----
> >
> > --
> > web site: http://www.gregn.net
> > gpg public key: http://www.gregn.net/pubkey.asc
> > skype: gregn1
> > (authorization required, add me to your contacts list first)
> > If we haven't been in touch before, e-mail me before adding me to your contacts.
> >
> > --
> > Free domains: http://www.eu.org/ or mail dns-manager@EU.org
